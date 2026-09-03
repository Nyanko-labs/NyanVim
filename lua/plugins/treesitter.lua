-- Parsers a fresh install needs for highlighting/indent out of the box. Anything
-- else: `:TSInstall <lang>` (needs the tree-sitter CLI, see :NyanHealth).
local ensure = {
  "bash",
  "c",
  "css",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- main branch is the rewrite required for Neovim 0.12; the old master
    -- branch crashes on markdown code-fence injections (iter_matches now
    -- returns a list of nodes per capture, which master's predicates mishandle).
    branch = "main",
    lazy = false, -- main branch does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      -- Install only what is missing (compiling every launch would be slow and
      -- would error when the CLI is absent); already-present parsers are left alone.
      local installed = ts.get_installed()
      local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, ensure)
      if #missing > 0 then
        if vim.fn.executable("tree-sitter") == 1 then
          ts.install(missing)
        else
          vim.notify(
            "NyanVim: "
              .. #missing
              .. " treesitter parsers missing and no `tree-sitter` CLI to build them (see :NyanHealth)",
            vim.log.levels.WARN
          )
        end
      end

      -- Highlighting starts per-buffer whenever a parser is available.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
