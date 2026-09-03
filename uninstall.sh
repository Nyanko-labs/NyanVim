#!/usr/bin/env bash
# uninstall.sh — remove NyanVim and restore the most recent backup, if any.
# Usage: uninstall.sh [--try]   (--try removes the side-by-side ~/.config/nyanvim install)
set -euo pipefail

APPNAME="nvim"
[[ "${1:-}" == "--try" ]] && APPNAME="nyanvim"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/${APPNAME}"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}/${APPNAME}"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/${APPNAME}"
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/${APPNAME}"

if [[ ! -f "$CONFIG/lua/nyanvim/init.lua" ]]; then
  echo "NyanVim is not installed at $CONFIG" >&2
  exit 1
fi

echo "This removes:"
for d in "$CONFIG" "$DATA" "$STATE" "$CACHE"; do [[ -e "$d" ]] && echo "  $d"; done
read -r -p "Continue? [y/N] " answer
[[ "$answer" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }

rm -rf "$CONFIG" "$DATA" "$STATE" "$CACHE"
echo "Removed NyanVim."

# restore the newest backup made by install.sh, if there is one
for d in "$CONFIG" "$DATA" "$STATE" "$CACHE"; do
  latest=$(ls -d "${d}.bak."* 2>/dev/null | sort | tail -1 || true)
  [[ -n "$latest" ]] && mv "$latest" "$d" && echo "Restored $latest -> $d"
done
exit 0
