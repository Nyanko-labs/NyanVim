-- WezTerm config used only by capture-screenshots.sh: the user's normal
-- config, opaque, no tab bar, and full-screen from the first frame.
local wezterm = require("wezterm")
local config = dofile(wezterm.home_dir .. "/.config/wezterm/wezterm.lua")
config.window_background_opacity = 1.0
config.macos_window_background_blur = 0
config.enable_tab_bar = false
wezterm.on("gui-startup", function(cmd)
  cmd = cmd or {}
  -- let the window reach full size before nvim measures the terminal,
  -- otherwise the dashboard renders for the pre-fullscreen row count
  local args = cmd.args or { "nvim" }
  cmd.args = { "/bin/sh", "-c", 'sleep 1.5; exec "$@"', "sh", table.unpack(args) }
  local _, _, window = wezterm.mux.spawn_window(cmd)
  window:gui_window():toggle_fullscreen()
end)
return config
