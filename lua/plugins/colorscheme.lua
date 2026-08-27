return {
  -- Active theme: tokyonight-moon re-grounded on the ARASAKA palette
  -- (CyberArch-Dotfiles, Cyberpunk 2077) — same black-red ground,
  -- red/yellow/cyan neons as the tmux/ghostty/kitty/wezterm configs.
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = false,
        terminal_colors = true,
        on_colors = function(c)
          -- ground
          c.bg = "#080002"
          c.bg_dark = "#050102"
          c.bg_float = "#0e0304"
          c.bg_popup = "#0e0304"
          c.bg_sidebar = "#0e0304"
          c.bg_statusline = "#0e0304"
          c.bg_highlight = "#1a060a"
          c.bg_visual = "#3a0f16"
          c.border = "#ff1e3c"
          -- text
          c.fg = "#ff4d5e"
          c.fg_dark = "#e08a95"
          c.fg_gutter = "#5a1a24"
          c.comment = "#c25c6e"
          -- arasaka neons
          c.blue = "#00b4ff"
          c.cyan = "#00ffc8"
          c.magenta = "#ff1e3c"
          c.purple = "#ff29d4"
          c.green = "#7dffb5" -- strings: soft mint (full matrix green is too loud)
          c.green1 = "#39ff88" -- accents: matrix green
          c.yellow = "#fce300"
          c.orange = "#ffe66b"
          c.red = "#ff1e3c"
          c.red1 = "#ff6b7d"
        end,
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.cyan, bold = true }
          hl.WinSeparator = { fg = "#1a060a" }
          hl.TelescopeBorder = { fg = c.purple }
          hl.TelescopeSelection = { bg = "#3a0f16" }
          hl.TelescopeMatching = { fg = c.cyan, bold = true }
        end,
      })
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  -- craftzdog's theme: selectable via :colorscheme solarized-osaka
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },
}
