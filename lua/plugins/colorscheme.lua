return {
  -- Active theme: nightcity.nvim (kyuna0312/night-city-palettes as a native
  -- colorscheme). Style "mix" = Night City Mix, the gamma-correct blend of
  -- Box UK × Solarized Osaka × Lucy: bg #101a1f, cyan #2bbcd5, teal #0cc7c2.
  -- Other styles: "boxuk" | "lucy" | "osaka" — switch live with <leader>th.
  {
    "kyuna0312/nightcity.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "mix",
      -- Transparency is owned here; the terminal supplies the ground
      -- (extras/<app>/night-city-mix in the palettes repo matches #101a1f).
      transparent = true,
      terminal_colors = true,
      -- neon accents on top of every style: magenta titles, cyan borders, teal splits
      on_highlights = function(hl, c)
        local blend = require("nightcity.util").blend
        hl.FloatBorder = { fg = c.cyan, bg = c.none }
        hl.FloatTitle = { fg = c.magenta, bg = c.none, bold = true }
        hl.WinSeparator = { fg = c.teal }
        hl.CursorLineNr = { fg = c.magenta, bold = true }
        hl.LineNr = { fg = c.fg_dim }
        hl.MatchParen = { fg = c.yellow, bold = true, underline = true }
        hl.IncSearch = { fg = c.bg_dark, bg = c.magenta, bold = true }
        hl.Visual = { bg = blend(c.purple, c.bg, 0.3) }
        hl.DashboardHeader = { fg = c.magenta }
        hl.DashboardIcon = { fg = c.cyan }
        hl.DashboardDesc = { fg = c.fg }
        hl.DashboardKey = { fg = c.pink, bold = true }
        hl.DashboardFooter = { fg = c.teal }
      end,
    },
    config = function(_, opts)
      require("nightcity").setup(opts)
      vim.cmd.colorscheme("nightcity-" .. (require("nyanvim.theme").saved() or opts.style))
    end,
  },
}
