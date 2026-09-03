# Architecture

```
init.lua                 leader, options, lazy.nvim, keymaps, autocmds, discipline, nyanvim.setup()
lua/config/
  lazy.lua               bootstrap; imports plugins/ and user/plugins/
  options.lua            editor options
  keymaps.lua            ALL global keymaps (single owner)
  autocmds.lua           autocommands
  which-key.lua          <leader> group labels only
lua/plugins/             one concern per file, every plugin lazy on event/cmd/keys
  colorscheme · ui · dashboard · telescope · lsp · conform · treesitter · editor · which-key · claudecode · ai
lua/nyanvim/
  init.lua               :NyanUpdate / :NyanHealth / :NyanConfig, loads lua/user
  theme.lua              theme picker + persistence
  health.lua             :checkhealth nyanvim
  discipline.lua         the hjkl nag
lua/user/                your overrides (git-ignored)
```

## Rules that keep it small

- **One owner per concern.** Keymaps in `config/keymaps.lua`, group labels in `config/which-key.lua`, transparency in `plugins/colorscheme.lua`. Nothing is set in two places.
- **Everything lazy.** Only the colorscheme, snacks, treesitter and the dashboard load at startup. `:Lazy profile` proves it.
- **Pinned.** `lazy-lock.json` is committed; install and update `restore` rather than `sync`.
- **Modern APIs.** `vim.lsp.config`/`vim.lsp.enable` (0.11), nvim-treesitter `main`, mason-lspconfig v2 auto-enable, `vim.uv`.
- **Nothing hard-coded to `~/.config/nvim`.** `stdpath("config")` everywhere, so `NVIM_APPNAME` installs work.

## Startup

`nvim --startuptime` on an M-series Mac: dashboard ~30 ms, a Lua file with LSP attached ~100 ms. Results per release live in `docs/perf/`.
