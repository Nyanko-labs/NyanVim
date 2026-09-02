return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 200 },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = { [[<c-\>]] },
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = { border = "curved", winblend = 3 },
      shell = vim.o.shell,
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    },
  },
  { "numToStr/Comment.nvim", event = "VeryLazy", config = true },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TodoTelescope",
    config = true,
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
  { "kdheepak/lazygit.nvim", dependencies = "nvim-lua/plenary.nvim", cmd = "LazyGit" },
  {
    -- maintained fork of ahmedkhalf/project.nvim (upstream is abandoned and
    -- calls deprecated vim.lsp.buf_get_clients on startup)
    "DrKJeff16/project.nvim",
    event = "VeryLazy",
    main = "project",
    opts = {},
  },
  { "AckslD/nvim-neoclip.lua", event = "VeryLazy", opts = {} },
}
