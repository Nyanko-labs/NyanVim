<div align="center">

# 🐱 NyanVim

**A small, fast Neovim setup you can read in one sitting.**

[![Neovim](https://img.shields.io/badge/Neovim-%E2%89%A5%200.11-0cc7c2?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-2bbcd5?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![Startup](https://img.shields.io/badge/%E2%9A%A1%20startup-~30ms-f2c74b?style=flat-square)](docs/perf/)
[![License](https://img.shields.io/badge/license-Apache--2.0-be59d6?style=flat-square)](LICENSE)
[![Stars](https://img.shields.io/github/stars/kyuna0312/NyanVim?style=flat-square&color=f37c4b)](https://github.com/kyuna0312/NyanVim/stargazers)

[**nyanvim.vercel.app**](https://nyanvim.vercel.app) · [Docs](docs/wiki/README.md) · [Keymaps](docs/wiki/Keymaps.md) · [Contributing](CONTRIBUTING.md)

<img src="https://raw.githubusercontent.com/kyuna0312/dotfiles/main/assets/logo.png" alt="NyanVim logo" width="420">

</div>

Open it and you have an IDE: file tree, fuzzy finder, language servers,
completion, Git, a terminal and Claude in a split. The dashboard is up in about
30 ms because every plugin loads only when you use it. The whole config is
~1,200 lines of Lua, one plugin per file, so when you want to change something
you can find it.

For people who like the polish of [NvChad](https://github.com/NvChad/NvChad)
and [LunarVim](https://github.com/LunarVim/LunarVim) but want a config they
can actually own.

```console
$ nvim
[lazy.nvim ]  6/41 plugins · 30ms
[mason     ]  69 tools armed
[treesitter]  79 parsers compiled
[nyanvim   ]  ready.  > ^ <
```

![NyanVim dashboard](assets/screenshots/dashboard.png)

## Contents

- [Quickstart](#quickstart)
- [Requirements](#requirements)
- [What it looks like](#what-it-looks-like)
- [Keys](#keys)
- [What's inside](#whats-inside)
- [Make it yours](#make-it-yours)
- [Theme](#theme)
- [Update and uninstall](#update-and-uninstall)
- [Performance](#performance)
- [How it's organised](#how-its-organised)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

## Quickstart

Try it next to your own config. Nothing in `~/.config/nvim` is touched:

```bash
curl -fsSL https://raw.githubusercontent.com/kyuna0312/NyanVim/main/install.sh | bash -s -- --try
NVIM_APPNAME=nyanvim nvim
```

Like it? Make it your default. Your old config, data and cache are moved to
`*.bak.<timestamp>` first:

```bash
curl -fsSL https://raw.githubusercontent.com/kyuna0312/NyanVim/main/install.sh | bash
nvim
```

Plugins install themselves on the first launch, pinned to the versions in
`lazy-lock.json` (about a minute). Then `:NyanHealth` tells you if anything is
missing.

<details>
<summary>Manual install</summary>

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/kyuna0312/NyanVim.git ~/.config/nvim
nvim
```
</details>

## Requirements

| Needed | For |
|--------|-----|
| **Neovim 0.11+** | `vim.lsp.config`, Telescope. Distro packages are often older; use the [official release](https://github.com/neovim/neovim/releases). |
| git, Node.js, ripgrep (`rg`), fd | plugins, LSP servers, Telescope search |
| a C compiler and the `tree-sitter` CLI | compiling Treesitter parsers (`brew install tree-sitter`, `cargo install tree-sitter-cli` or `npm i -g tree-sitter-cli`) |
| a [Nerd Font](https://www.nerdfonts.com/) | icons |
| `claude`, `opencode`, `ollama` | optional, for the AI keys |

## What it looks like

| Editing, with the file tree | Telescope |
|-----------------------------|-----------|
| ![Editing a Lua file with the file tree open](assets/screenshots/ide-view.png) | ![Telescope find files with preview](assets/screenshots/telescope.png) |

| LSP hover | Theme picker |
|-----------|--------------|
| ![Hover documentation](assets/screenshots/lsp.png) | ![Theme picker previewing Box UK](assets/screenshots/theme.png) |

| Floating terminal |
|-------------------|
| ![Floating terminal](assets/screenshots/terminal.png) |

## Keys

The leader is **Space**. Press it and pause: which-key lists every group.
`Space f k` searches every mapping by what it does. The full list is in
[docs/wiki/Keymaps.md](docs/wiki/Keymaps.md).

### A normal day

| Key | Action |
|-----|--------|
| `Space f f` | find a file by name |
| `Space f g` | search text in the whole project |
| `Ctrl b` | show or hide the file tree |
| `Shift h` / `Shift l` | previous / next open file |
| `g d` · `K` | go to definition · docs under the cursor |
| `Space c a` | code action: fix, import, refactor |
| `Space c f` | format the file |
| `Space r n` | rename symbol everywhere |
| `Space g g` | LazyGit |
| `Ctrl \` | floating terminal |
| `Space a c` | Claude Code in a split |
| `Space t h` | theme picker |

### NyanVim itself — `Space n`

Like LunarVim's `Space L`: everything about the config under one key.

| Key | Command | Action |
|-----|---------|--------|
| `Space n u` | `:NyanUpdate` | pull the latest NyanVim, restore pinned plugins |
| `Space n h` | `:NyanHealth` | check Neovim version, tools, compiler |
| `Space n c` | `:NyanConfig` | open your overrides file (created on first use) |
| `Space n k` | `:Telescope keymaps` | keymap cheatsheet |
| `Space n l` · `Space n m` | `:Lazy` · `:Mason` | plugin and LSP-tool managers |
| `Space n t` | | theme picker |

## What's inside

| Area | Plugins | Notes |
|------|---------|-------|
| Plugin manager | [lazy.nvim](https://github.com/folke/lazy.nvim) | 41 plugins, 6 load at startup, the rest on `event`/`cmd`/`keys`. `:Lazy profile` shows the breakdown. |
| LSP | mason, mason-lspconfig v2, nvim-lspconfig | Neovim 0.11 `vim.lsp.config` API. Lua, Python, TypeScript, Rust, JSON, HTML, CSS pre-installed; anything you add in `:Mason` is enabled automatically. Inline diagnostics on. |
| Completion | nvim-cmp, LuaSnip, friendly-snippets, lspkind | Tab through snippets, bordered docs. |
| Syntax | nvim-treesitter (`main`) | Highlight and indent; 19 parsers install themselves on first launch. |
| Finding | Telescope, fzf-native, project.nvim, neoclip | Files, grep, symbols, projects, yank history, keymaps. |
| Files and UI | nvim-tree, lualine, bufferline, snacks.nvim, colorizer, illuminate | Tree on the right. snacks supplies notifications, indent guides, `vim.ui.input`. Hex colours show inline. |
| Git | gitsigns, diffview, lazygit | Blame on the current line, `Space g g` for LazyGit. |
| Editing | conform, autopairs, Comment.nvim, todo-comments, toggleterm | Format on save with stylua, black, prettier; LSP fallback when a formatter is missing. |
| AI | claudecode.nvim, opencode.nvim, gen.nvim | Claude Code and opencode CLIs in a split, or a local Ollama model. All optional, no API keys in the config. |
| Discovery | which-key v3 | Group labels only; every mapping lives in one file. |
| Theme | [nightcity.nvim](https://github.com/kyuna0312/nightcity.nvim) | Night City Mix, four styles, live switcher. |
| Own code | `lua/nyanvim/` | `:Nyan*` commands, health check, theme picker, the `hjkl` nag. |

## Make it yours

You never edit NyanVim's own files. Personal changes live in `lua/user/`,
which is git-ignored, so `:NyanUpdate` cannot overwrite them.

- **`lua/user/init.lua`** — options, keymaps, colorscheme. `Space n c` opens it
  and creates it from the example the first time. Errors in it are reported at
  startup; the rest of the config still loads.
- **`lua/user/plugins/*.lua`** — extra plugins as normal lazy.nvim specs, picked
  up automatically. Use a built-in plugin's name and your spec merges over the
  default:

```lua
-- lua/user/plugins/mine.lua
return {
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },       -- add
  { "nvim-tree/nvim-tree.lua", opts = { view = { side = "left" } } }, -- change
  { "RRethy/vim-illuminate", enabled = false },                        -- remove
}
```

Adding a language: `:Mason` → install the server (enabled on the next file
you open), `:TSInstall <lang>` for highlighting, and a formatter in your own
conform spec if you want one. Details in
[docs/wiki/Customizing.md](docs/wiki/Customizing.md).

## Theme

**Night City Mix** from [night-city-palettes](https://github.com/kyuna0312/night-city-palettes):
a blue-grey ground with a neon pop, the same palette across tmux, Ghostty,
kitty, WezTerm and starship in [kyuna0312/dotfiles](https://github.com/kyuna0312/dotfiles).

`Space t h` opens the picker: `j`/`k` preview `mix`, `boxuk`, `lucy` and
`osaka` live, Enter keeps, Esc puts the previous one back. The choice is
remembered across restarts.

The editor background is transparent; the terminal supplies the ground. For
the intended look set your terminal background to `#101a1f`, or make the
editor opaque with one line (see [Troubleshooting](#troubleshooting)).

| Token | Hex | Used for |
|-------|-----|----------|
| ground | `#101a1f` | terminal background |
| azure | `#2ba3c9` | functions, properties |
| green | `#49d575` | keywords |
| teal | `#0cc7c2` | strings, matches, cursor line number |
| apricot | `#ffa066` | numbers, booleans, constants |
| yellow | `#f2c74b` | types, warnings |
| red | `#f65162` | errors |
| purple | `#be59d6` | special |
| violet | `#9d7bd8` | todo, hints |

## Update and uninstall

```vim
:NyanUpdate        " git pull, then :Lazy restore to the pinned versions
```

```bash
~/.config/nvim/uninstall.sh            # default install
~/.config/nyanvim/uninstall.sh --try   # side-by-side install
```

Uninstall removes NyanVim's config, data, state and cache and restores the
newest backup `install.sh` made.

## Performance

`./bench.sh --runs 10` measures `nvim --startuptime` and writes one file per
release to [`docs/perf/`](docs/perf/). On an M-series Mac:

| Release | Mean | Median | What changed |
|---------|------|--------|--------------|
| v1.0.0 | ~215 ms | | everything loaded eagerly |
| [v1.1.0](docs/perf/2026-09-03-v1.1.0.md) | 30.2 ms | 23.2 ms | lazy-loading everywhere |
| [v1.2.0](docs/perf/2026-09-03-v1.2.0.md) | 28.5 ms | 25.7 ms | `:Nyan*` commands, user layer |
| [v1.3.0](docs/perf/2026-09-03-v1.3.0.md) | 30.8 ms | 27.5 ms | parser auto-install, lockfile restore |

Opening a Lua file with the LSP attached takes about 100 ms.

## How it's organised

```
init.lua                 leader, options, lazy.nvim, keymaps, autocmds, nyanvim.setup()
lua/config/
  lazy.lua               bootstrap; imports plugins/ and user/plugins/
  options.lua            editor options
  keymaps.lua            ALL global keymaps (single owner)
  autocmds.lua           autocommands
  which-key.lua          <leader> group labels only
lua/plugins/             one concern per file, every plugin lazy
  colorscheme · ui · dashboard · telescope · lsp · conform
  treesitter · editor · which-key · claudecode · ai
lua/nyanvim/             :Nyan* commands · health · theme picker · discipline
lua/user/                your overrides (git-ignored)
docs/wiki/               the docs · docs/perf/  benchmarks
site/                    nyanvim.vercel.app
```

Rules that keep it small: one owner per concern (keymaps, which-key labels,
transparency each live in exactly one file), everything lazy, versions pinned,
modern APIs only (`vim.lsp.config`, treesitter `main`, `vim.uv`), and nothing
hard-coded to `~/.config/nvim` so `NVIM_APPNAME` installs work. More in
[docs/wiki/Architecture.md](docs/wiki/Architecture.md).

## Troubleshooting

Start with `:NyanHealth`, then `:Lazy` for plugin errors and `:messages` for
the last error text.

| Symptom | Fix |
|---------|-----|
| Icons are boxes | install a Nerd Font and select it in the terminal |
| Background is black, not blue-grey | set the terminal background to `#101a1f`, or in `lua/user/plugins/theme.lua`: `return { { "kyuna0312/nightcity.nvim", opts = { transparent = false } } }` |
| No syntax colours for a language | `:TSInstall <lang>`; if it fails, install the `tree-sitter` CLI and a C compiler |
| No completion or LSP for a language | `:Mason`, install the server, reopen the file |
| `Space t h` shows an empty list | you typed into the prompt; Esc, then `j`/`k` |
| Plugins broke after an update | `:Lazy restore` puts back the pinned versions |

More in [docs/wiki/Troubleshooting.md](docs/wiki/Troubleshooting.md). Still
stuck? [Open an issue](https://github.com/kyuna0312/NyanVim/issues) with
`:NyanHealth`, `:messages` and `nvim --version`.

## Credits

Layout after [craftzdog's dotfiles](https://github.com/craftzdog/dotfiles-public);
the try-before-you-switch installer and `:Nyan*` menu after
[LunarVim](https://github.com/LunarVim/LunarVim); the theme switcher after
[NvChad](https://github.com/NvChad/NvChad); the user layer after
[doom-nvim](https://github.com/doom-neovim/doom-nvim). Palette by
[night-city-palettes](https://github.com/kyuna0312/night-city-palettes).
Apache-2.0, see [LICENSE](LICENSE).
