# Installation

## Requirements

| Tool | Why |
|------|-----|
| Neovim **0.11+** | `vim.lsp.config`, Telescope. Distro packages are often too old; use the official release. |
| git, node, ripgrep (`rg`), fd | plugins, LSP servers, Telescope search |
| a C compiler + `tree-sitter` CLI | compiling Treesitter parsers (`brew install tree-sitter` / `cargo install tree-sitter-cli`) |
| a [Nerd Font](https://www.nerdfonts.com/) | icons |
| `claude`, `opencode`, `ollama` | optional, for the AI keys |

`:NyanHealth` inside Neovim checks all of these.

## Try it without replacing your config

```bash
curl -fsSL https://raw.githubusercontent.com/kyuna0312/NyanVim/main/install.sh | bash -s -- --try
NVIM_APPNAME=nyanvim nvim
```

This installs to `~/.config/nyanvim` and keeps its plugins, data and cache under the `nyanvim` name. Your `~/.config/nvim` is not touched. A handy alias: `alias nyanvim='NVIM_APPNAME=nyanvim nvim'`.

## Make it your default

```bash
curl -fsSL https://raw.githubusercontent.com/kyuna0312/NyanVim/main/install.sh | bash
nvim
```

Your existing config, data, state and cache are moved to `*.bak.<timestamp>` first.

Manual equivalent: `git clone https://github.com/kyuna0312/NyanVim.git ~/.config/nvim && nvim`.

## First launch

Plugins install from the pinned `lazy-lock.json` (about a minute). Treesitter parsers for 19 languages compile on the first start; that needs the `tree-sitter` CLI. Then run `:NyanHealth`.

## Update

`:NyanUpdate` (or `Space n u`) runs `git pull` and then `:Lazy restore`, so you get exactly the plugin versions the release was tested with. Your `lua/user/` files are git-ignored and survive updates.

## Uninstall

```bash
~/.config/nvim/uninstall.sh          # default install
~/.config/nyanvim/uninstall.sh --try # side-by-side install
```

It removes config, data, state and cache for that install and restores the newest backup if one exists.
