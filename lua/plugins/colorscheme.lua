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
      -- Transparency is owned here (autocmds.lua used to clear bg behind the
      -- theme's back); the terminal supplies the matching #161e22 ground.
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(c)
        -- grounds. solarized-osaka keys: base04 (darkest) … base0 (main fg);
        -- there is no bg_dark/comment/teal/purple key in this palette.
        c.base04 = "#111519"
        c.base03 = "#161e22"
        c.base02 = "#222c31"
        c.base01 = "#60778c" -- comments / secondary fg
        c.base00 = "#8fa3a8"
        c.base0 = "#b8c7cc" -- main fg
        c.bg = "#161e22"
        c.bg_highlight = "#222c31"
        c.bg_float = "#1b2228"
        c.bg_popup = "#1b2228"
        c.bg_sidebar = "#1b2228"
        c.bg_statusline = "#111519"
        c.border = "#017c9d"
        c.fg = "#b8c7cc"
        -- Box UK accents. Highlight groups read the *500 variants, so set
        -- both the base key and its 500 twin.
        c.blue, c.blue500 = "#017c9d", "#017c9d"
        c.cyan, c.cyan500 = "#15b8ae", "#15b8ae"
        c.green, c.green500 = "#019d76", "#019d76"
        c.yellow, c.yellow500 = "#ffcb6e", "#ffcb6e"
        c.orange, c.orange500 = "#f77669", "#f77669"
        c.red, c.red500 = "#f77669", "#f77669"
        c.magenta, c.magenta500 = "#b750ae", "#b750ae"
        c.violet, c.violet500 = "#b750ae", "#b750ae"
      end,
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.cyan500, bold = true }
        hl.TelescopeBorder = { fg = c.magenta500 }
        hl.TelescopeMatching = { fg = c.cyan500, bold = true }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
}
