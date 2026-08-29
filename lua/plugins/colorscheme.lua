return {
  -- Active theme: LUCY (Cyberpunk: Edgerunners) — craftzdog's solarized-osaka,
  -- a calm cool-teal cyberpunk that matches the tmux/ghostty/kitty/wezterm
  -- configs (bg #00141a, teal #2aa298, magenta #d33682).
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
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.cyan, bold = true }
        hl.TelescopeBorder = { fg = c.magenta }
        hl.TelescopeMatching = { fg = c.cyan, bold = true }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd([[colorscheme solarized-osaka]])
    end,
  },
}
