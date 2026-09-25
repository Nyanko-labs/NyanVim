return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      -- external formatters are optional: when one is missing conform falls
      -- back to the LSP (lsp_format = "fallback")
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        go = { "gofmt" }, -- ships with Go
        sh = { "shfmt" },
      },
      -- <leader>tf flips vim.g.nyanvim_autoformat (default on)
      format_on_save = function()
        if vim.g.nyanvim_autoformat == false then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
    },
  },
}
