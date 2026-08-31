return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { side = "right", width = 35 },
        filters = { dotfiles = true },
        -- Buffer-local extras on top of the defaults; these used to be
        -- global maps in keymaps.lua, which made <Del> dangerous elsewhere.
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          api.config.mappings.default_on_attach(bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "<F2>", api.fs.rename, opts)
          vim.keymap.set("n", "<Del>", api.fs.remove, opts)
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
        },
      })
    end,
  },
  { "RRethy/vim-illuminate" },
  { "lukas-reineke/indent-blankline.nvim" },
}
