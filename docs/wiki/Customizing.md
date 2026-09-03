# Customizing

You never edit NyanVim's own files. Everything personal goes in `lua/user/`, which is git-ignored, so `:NyanUpdate` cannot overwrite it.

## `lua/user/init.lua`

Open it with `Space n c` (`:NyanConfig`). The first time, it is created from `lua/user/init.lua.example`. It runs after everything else, so it can override any option or keymap:

```lua
vim.opt.relativenumber = false
vim.opt.wrap = true
vim.keymap.set("n", "<leader>x", "<cmd>echo 'hi'<cr>", { desc = "My map" })
```

If the file has an error you get a red notification at startup with the line number; the rest of the config still loads.

## `lua/user/plugins/*.lua`

Any file here is a normal [lazy.nvim](https://github.com/folke/lazy.nvim) spec and is imported automatically:

```lua
-- lua/user/plugins/surround.lua
return {
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
}
```

## Changing a built-in plugin

Use the same plugin name; lazy.nvim merges your spec over NyanVim's:

```lua
-- lua/user/plugins/colorscheme.lua — opaque background
return {
  { "kyuna0312/nightcity.nvim", opts = { transparent = false } },
}
```

```lua
-- lua/user/plugins/tree.lua — file tree on the left
return {
  { "nvim-tree/nvim-tree.lua", opts = { view = { side = "left" } } },
}
```

To disable one: `{ "RRethy/vim-illuminate", enabled = false }`.

## Adding a language

1. `:Mason`, find the server, press `i`. It is enabled on the next file you open (mason-lspconfig v2 auto-enable).
2. `:TSInstall <lang>` for highlighting (needs the `tree-sitter` CLI).
3. Optional: a formatter in your own conform spec:

```lua
-- lua/user/plugins/conform.lua
return {
  { "stevearc/conform.nvim", opts = { formatters_by_ft = { go = { "gofmt" } } } },
}
```

## Keymap rules

Global keymaps live in `lua/config/keymaps.lua`; which-key only labels groups. In your overrides, `vim.keymap.set` is fine. Remember `<Space>t` is the toggle/theme group, so mapping `<Space>t` alone will delay `Space t h`.
