return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "AckslD/nvim-neoclip.lua",
      "nvim-telescope/telescope-project.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- build output and lockfiles never belong in a picker
          file_ignore_patterns = {
            "^%.git/",
            "node_modules/",
            "dist/",
            "build/",
            "target/",
            "%.next/",
            "__pycache__/",
            "%.venv/",
            "venv/",
            "vendor/",
            "%.dart_tool/",
            "package%-lock%.json",
            "yarn%.lock",
            "pnpm%-lock%.yaml",
            "Cargo%.lock",
            "%.DS_Store",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "projects")
      pcall(require("telescope").load_extension, "neoclip")
    end,
  },
}
