return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        current_line_blame_opts = { delay = 200 },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = { border = "curved", winblend = 3 },
        shell = vim.o.shell,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })
    end,
  },
  { "numToStr/Comment.nvim", config = true },
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "kdheepak/lazygit.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    -- maintained fork of ahmedkhalf/project.nvim (upstream is abandoned and
    -- calls deprecated vim.lsp.buf_get_clients on startup)
    "DrKJeff16/project.nvim",
    config = function()
      require("project").setup()
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },
}
