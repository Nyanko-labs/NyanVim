#!/usr/bin/env bash
# capture-screenshots.sh — take NyanVim screenshots for README (macOS)
# Requirements: wezterm, screencapture (built in), swift (Xcode CLT) for the window id
# Uses scripts/capture-wezterm.lua so the window is opaque, tab-less and full-screen.
set -euo pipefail

REPO=$(git rev-parse --show-toplevel)
OUT="${REPO}/assets/screenshots"
mkdir -p "$OUT"
command -v wezterm >/dev/null || { echo "error: wezterm not found" >&2; exit 1; }

# Sample Lua file for the LSP demo
DEMO_FILE=$(mktemp -t nyanvim-demo).lua
cat > "$DEMO_FILE" << 'LUA'
-- NyanVim LSP demo
local M = {}

---@param name string
---@return string
function M.greet(name)
  return "Hello, " .. name
end

local function setup()
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = { diagnostics = { globals = { "vim" } } },
    },
  })
end

return M
LUA

PANE=""
cleanup() {
  [[ -n "$PANE" ]] && wezterm cli kill-pane --pane-id "$PANE" 2>/dev/null || true
  rm -f "$DEMO_FILE"
}
trap cleanup EXIT

send() { wezterm cli send-text --no-paste --pane-id "$PANE" -- "$1"; }

# CoreGraphics id of the biggest WezTerm window (the full-screen one lives on
# its own Space, so it is not "on screen" from the shell's point of view)
window_id() {
  swift - <<'SWIFT'
import CoreGraphics
let list = CGWindowListCopyWindowInfo([.optionAll], kCGNullWindowID) as! [[String: Any]]
var best: (Int, Double) = (0, 0)
for w in list where ((w["kCGWindowOwnerName"] as? String) ?? "").lowercased().contains("wezterm") {
  let b = w["kCGWindowBounds"] as! [String: Double]
  let area = b["Width"]! * b["Height"]!
  if area > best.1 { best = (w["kCGWindowNumber"] as! Int, area) }
}
if best.0 != 0 { print(best.0) }
SWIFT
}

shot() {
  sleep 2
  screencapture -x -o -l "$WIN" "${OUT}/$1.png"
  echo "  saved: $1.png"
}

echo "Spawning NyanVim..."
# scripts/capture-wezterm.lua = the user's config + opaque + no tab bar + fullscreen
wezterm --config-file "${REPO}/scripts/capture-wezterm.lua" \
  start --always-new-process --cwd "$REPO" -- nvim >/dev/null 2>&1 &
sleep 7
# talk to the GUI we just started, not a stale socket from another session
export WEZTERM_UNIX_SOCKET
WEZTERM_UNIX_SOCKET=$(ls -t "$HOME/.local/share/wezterm"/gui-sock-* | head -1)
PANE=$(wezterm cli list --format json | python3 -c 'import json,sys; print(max(json.load(sys.stdin), key=lambda p: p["pane_id"])["pane_id"])')
WIN=$(window_id)
[[ -n "$WIN" ]] || { echo "error: WezTerm window not found" >&2; exit 1; }

echo "1/6 Dashboard..."
shot "dashboard"

echo "2/6 IDE view with file explorer..."
send ":e ${DEMO_FILE}"$'\r'
sleep 2
send $'\x02'  # <C-b> = toggle nvim-tree
shot "ide-view"

echo "3/6 Telescope fuzzy finder..."
send $'\x1b'; sleep 0.3
send " ff"    # <Space>ff
sleep 0.5
send "theme"  # narrow to lua/nyanvim/theme.lua so the preview shows code
shot "telescope"

echo "4/6 LSP hover..."
send $'\x1b'$'\x1b'; sleep 0.5
send ":e ${DEMO_FILE}"$'\r'; sleep 1
send "6G"     # function M.greet
sleep 0.3
send "K"
shot "lsp"

echo "5/6 Theme picker..."
send $'\x1b'; sleep 0.3
send " th"    # <Space>th
sleep 0.5
send $'\x1b'; sleep 0.3   # picker to normal mode
send "j"      # preview the second style
shot "theme"

echo "6/6 Floating terminal..."
send $'\x1b'$'\x1b'; sleep 0.5
send " tt"    # <Space>tt
shot "terminal"

echo ""
echo "Screenshots saved to: ${OUT}/"
ls -1 "${OUT}/"
