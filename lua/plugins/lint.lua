return {
  {
    -- linters the language servers do not cover; each runs only if its binary is on PATH
    "mfussenegger/nvim-lint",
    -- BufReadPre so the autocmd below exists before the first buffer's BufReadPost
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      -- markdownlint: style nags off, see markdownlint.jsonc at the config root
      lint.linters["markdownlint-cli2"].args = { "--config", vim.fn.stdpath("config") .. "/markdownlint.jsonc", "-" }
      lint.linters_by_ft = {
        dockerfile = { "hadolint" },
        markdown = { "markdownlint-cli2" },
        python = { "ruff" },
      }
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nyanvim_lint", { clear = true }),
        callback = function()
          local names = lint.linters_by_ft[vim.bo.filetype] or {}
          for _, name in ipairs(names) do
            if vim.fn.executable(lint.linters[name].cmd) == 1 then
              lint.try_lint(name)
            end
          end
        end,
      })
    end,
  },
}
