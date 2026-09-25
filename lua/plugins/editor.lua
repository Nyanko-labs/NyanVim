return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 200 },
      -- buffer-local hunk maps; the Git group in keymaps.lua covers the rest
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = bufnr, desc = desc })
        end
        map("]h", function()
          gs.nav_hunk("next")
        end, "Next hunk")
        map("[h", function()
          gs.nav_hunk("prev")
        end, "Previous hunk")
        map("<leader>gp", gs.preview_hunk, "Preview hunk")
        map("<leader>ga", gs.stage_hunk, "Stage hunk")
        map("<leader>gr", gs.reset_hunk, "Reset hunk")
      end,
    },
  },
  {
    -- one set of <C-hjkl> for nvim splits and tmux panes; tmux.conf has the matching binds
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window right" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash treesitter select",
      },
    },
  },
  {
    "nvim-mini/mini.surround",
    -- gs prefix (LazyVim's choice) keeps s free for flash
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    },
    keys = { { "gs", mode = { "n", "v" } } },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>cd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics list" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols outline" },
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
