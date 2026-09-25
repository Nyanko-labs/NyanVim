return {
  -- snacks is already pulled in by claudecode.nvim; use it for the pretty
  -- vim.notify popups, indent guides and the floating vim.ui.input.
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    opts = {
      notifier = {},
      indent = {},
      input = {},
      bigfile = {},
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = {
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
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "nightcity",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode)
              return "▊ " .. mode
            end,
          },
        },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 }, "diagnostics" },
        lualine_x = {
          {
            -- Space t f flips it; shown only while on so the bar stays quiet
            function()
              return vim.g.nyanvim_autoformat == false and "" or "󰉿 fmt"
            end,
            color = { fg = require("nightcity.colors").setup().teal },
          },
          {
            function()
              local names = {}
              for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                names[#names + 1] = client.name
              end
              return #names > 0 and (" " .. table.concat(names, " ")) or ""
            end,
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      },
    },
  },
  { "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },
  -- #2bbcd5 → shows the colour inline; handy when editing palettes
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = { user_default_options = { names = false } },
  },
}
