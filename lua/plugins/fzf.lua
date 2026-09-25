return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- hidden files show, .gitignore still applies (fd/rg honour it)
      files = { fd_opts = "--color=never --hidden --type f --type l --exclude .git" },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      },
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
      oldfiles = { cwd_only = true, include_current_session = true },
      keymap = {
        fzf = { ["ctrl-q"] = "select-all+accept" }, -- send everything to the quickfix list
      },
    },
    config = function(_, opts)
      local fzf = require("fzf-lua")
      fzf.setup(opts)
      fzf.register_ui_select() -- vim.ui.select (code actions, rename prompts) goes through fzf
    end,
  },
}
