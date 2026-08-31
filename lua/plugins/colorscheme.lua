return {
  -- Active theme: nightcity.nvim (kyuna0312/night-city-palettes as a native
  -- colorscheme). Style "mix" = Night City Mix, the gamma-correct blend of
  -- Box UK × Solarized Osaka × Lucy: bg #101a1f, cyan #2bbcd5, teal #0cc7c2.
  -- Other styles: "boxuk" | "lucy" | "osaka".
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
    },
    config = function(_, opts)
      require("nightcity").setup(opts)
      vim.cmd.colorscheme("nightcity")
    end,
  },
}
