return {
  -- Active theme: BOX UK Contrast (rainglow) — the solarized-osaka engine with
  -- its palette overridden to the Box UK set (ported from the vonqo IntelliJ
  -- theme). Matches the tmux/ghostty/kitty/wezterm configs: bg #161e22,
  -- cyan #017c9d, teal #15b8ae, green #019d76, coral #f77669.
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
      on_colors = function(c)
        -- grounds
        c.bg = "#161e22"
        c.bg_dark = "#111519"
        c.bg_float = "#1b2228"
        c.bg_popup = "#1b2228"
        c.bg_sidebar = "#1b2228"
        c.bg_statusline = "#111519"
        c.bg_highlight = "#222c31"
        c.bg_visual = "#233b47"
        c.border = "#017c9d"
        c.fg = "#b8c7cc"
        c.fg_dark = "#8fa3a8"
        c.fg_gutter = "#303b47"
        c.comment = "#60778c"
        -- Box UK accents
        c.cyan = "#017c9d"
        c.blue = "#017c9d"
        c.teal = "#15b8ae"
        c.green = "#019d76"
        c.green1 = "#15b8ae"
        c.yellow = "#ffcb6e"
        c.orange = "#f77669"
        c.red = "#f77669"
        c.magenta = "#b750ae"
        c.purple = "#b750ae"
      end,
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.teal, bold = true }
        hl.TelescopeBorder = { fg = c.magenta }
        hl.TelescopeMatching = { fg = c.teal, bold = true }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
}
