# 🐱 NyanVim

<div align="center">

[![Neovim](https://img.shields.io/badge/Neovim-%E2%89%A5%200.11-15b8ae?style=flat-square&logo=neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-017c9d?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org)
[![Startup](https://img.shields.io/badge/%E2%9A%A1%20startup-~177ms-ffcb6e?style=flat-square)](docs/perf/)
[![License](https://img.shields.io/badge/license-Apache--2.0-b750ae?style=flat-square)](LICENSE)
[![Stars](https://img.shields.io/github/stars/kyuna0312/NyanVim?style=flat-square&color=f77669)](https://github.com/kyuna0312/NyanVim/stargazers)

</div>

A hand-rolled Neovim config — IDE features, fast startup, VSCode-like feel.
Organized [craftzdog](https://github.com/craftzdog/dotfiles-public)-style: a thin
[lazy.nvim](https://github.com/folke/lazy.nvim) loader and one plugin per file.

```console
$ nvim
[lazy.nvim ]  39 plugins · 177ms
[mason     ]  41 language servers armed
[treesitter]  79 parsers compiled
[nyanvim   ]  ready.  > ^ <
```

<div align="center">
  <img src="https://raw.githubusercontent.com/kyuna0312/dotfiles/master/assets/logo.png" alt="NyanVim Logo">
</div>

<div align="center">

![Dashboard](assets/screenshots/dashboard.png)

</div>

## Showcase

| IDE View | Fuzzy Finder |
|----------|-------------|
| ![IDE View](assets/screenshots/ide-view.png) | ![Telescope](assets/screenshots/telescope.png) |

| LSP Hover | Terminal |
|-----------|----------|
| ![LSP](assets/screenshots/lsp.png) | ![Terminal](assets/screenshots/terminal.png) |

## Features

- **Claude in the editor** — [`coder/claudecode.nvim`](https://github.com/coder/claudecode.nvim): run the Claude Code CLI in a split, send selections/buffers, apply diffs. No API key.
- **LSP** — mason + nvim-lspconfig on the modern `vim.lsp.config` API (Neovim 0.11+). 7 servers pre-installed; anything added via `:MasonInstall` is auto-enabled (mason-lspconfig v2). Inline diagnostics on.
- **Single-owner keymaps** — every global map lives in `config/keymaps.lua`; which-key only labels the groups.
- **Completion** — nvim-cmp + LuaSnip + lspkind.
- **Fuzzy finding** — Telescope (fzf-native, ui-select, projects, neoclip).
- **Syntax** — Treesitter (highlight + indent).
- **UI** — NyanVim dashboard, lualine, bufferline, nvim-tree, indent guides, illuminate.
- **Git** — gitsigns, diffview, lazygit.
- **Editor** — toggleterm, autopairs, Comment.nvim, todo-comments, project.nvim.
- **Keymap discovery** — which-key (v3).
- **Theme** — **BOX UK Contrast**: the [solarized-osaka](https://github.com/craftzdog/solarized-osaka.nvim) engine with its palette overridden to the Box UK set (ported from the [vonqo](https://github.com/vonqo/vonqo) IntelliJ theme), a calm deep blue-grey + teal palette shared across the whole stack.
- **Discipline** — habit-trainer that nags on `hjkl`/arrow spamming.

## Requirements

| Dependency | Version | Notes |
|-----------|---------|-------|
| Neovim | **>= 0.11** | required — Telescope and `vim.lsp.enable` need it. [Install](https://neovim.io) |
| Git | >= 2.19 | |
| Node.js | any LTS | for LSP servers |
| ripgrep | any | `rg` — Telescope grep |
| fd | any | `fd` — Telescope find |
| C compiler | any | `gcc`/`clang` — Treesitter |
| tree-sitter CLI | any | `tree-sitter` — compiles Treesitter parsers (`:TSUpdate`). `cargo install tree-sitter-cli` / `npm i -g tree-sitter-cli` / release binary |
| Nerd Font | any | [nerdfonts.com](https://www.nerdfonts.com/) |
| Claude Code CLI | any | optional — for in-editor Claude (`claude` on PATH) |

> **Note:** Distro packages are often too old (e.g. Ubuntu ships 0.9.x). Use the
> official AppImage or a recent build to get **0.11+**.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/kyuna0312/NyanVim/main/install.sh | bash
```

Or manually:

```bash
# Back up existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/kyuna0312/NyanVim.git ~/.config/nvim

# Start Neovim — plugins install automatically on first launch
nvim
```

After install, run `:checkhealth nyanvim` to verify your system is set up correctly.

## Key Keymaps

Leader key: **`<Space>`**

### Navigation
| Key | Action |
|-----|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep |
| `<Space>fb` | Open buffers |
| `<Space>fh` | Help tags |
| `<C-b>` | Toggle file explorer (nvim-tree) |
| `<Space>e` | Toggle file explorer |
| `<S-h>` / `<S-l>` | Prev / Next buffer |
| `<C-h/j/k/l>` | Navigate windows |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover docs |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions |
| `<Space>cf` | Format buffer |

### AI / Claude
| Key | Action |
|-----|--------|
| `<Space>ac` | Toggle Claude split |
| `<Space>af` | Focus Claude |
| `<Space>as` | Send visual selection (visual mode) |
| `<Space>ab` | Add current buffer to context |
| `<Space>at` | Add file from tree |
| `<Space>aa` / `<Space>ad` | Accept / Deny diff |
| `<Space>ar` / `<Space>aC` | Resume / Continue session |
| `<Space>am` | Select model |

### Git & Tools
| Key | Action |
|-----|--------|
| `<Space>gg` | LazyGit |
| `<Space>gd` | Diffview |
| `<Space>gs` / `gb` / `gc` | Git status / branches / commits |
| `<Space>pp` | Switch project |
| `<Space>t` | Toggle terminal |
| `<C-\>` | Toggle floating terminal |
| `<Space>cm` / `:Mason` | LSP/tool installer |
| `:Dashboard` | NyanVim dashboard |

Press `<Space>` and wait to browse all groups via which-key.

## Structure

```
init.lua                 -- leader, options, then loads config + discipline
lua/
  config/
    lazy.lua             -- bootstrap + { import = "plugins" }
    options.lua          -- editor options
    keymaps.lua          -- ALL global keymaps (single owner)
    autocmds.lua         -- autocommands
    which-key.lua        -- <leader> group labels only
  plugins/               -- one concern per file, all auto-imported
    colorscheme · ui · dashboard · telescope · lsp
    treesitter · editor · which-key · claudecode
  nyanvim/
    init.lua · health.lua · discipline.lua
```

## Theme — BOX UK Contrast

The colorscheme is the [solarized-osaka](https://github.com/craftzdog/solarized-osaka.nvim)
engine with its palette overridden to **Box UK Contrast** in
`lua/plugins/colorscheme.lua` (`on_colors`) — a calm deep blue-grey + teal set:

The background is transparent (owned by the colorscheme, not an autocmd) —
the terminal supplies the matching `#161e22` ground.

| Token | Hex | Where |
|-------|-----|-------|
| blue-grey | `#161e22` | terminal ground behind the transparent bg |
| cyan | `#017c9d` | functions, properties, borders |
| green | `#019d76` | keywords |
| teal | `#15b8ae` | strings, numbers, cursor line nr, Telescope matching |
| yellow | `#ffcb6e` | types, warnings |
| coral | `#f77669` | errors, deleted |
| purple | `#b750ae` | Telescope frame |

Pairs with the same palette across tmux, Ghostty, kitty, WezTerm, starship and
Übersicht — see [kyuna0312/dotfiles](https://github.com/kyuna0312/dotfiles).

## Customize

Add a file under `lua/plugins/` returning a lazy.nvim spec — it's picked up
automatically by `{ import = "plugins" }`:

```lua
-- lua/plugins/my-plugin.lua
return {
  { "owner/repo", opts = {} },
}
```

## Update

```bash
cd ~/.config/nvim
git pull
nvim --headless "+Lazy! sync" +qa
```

## Languages Included

LSP servers auto-installed via mason: **Lua · Python · TypeScript/JavaScript ·
Rust · JSON · HTML · CSS**. Treesitter additionally parses Go, Bash, Markdown,
Vim, and more.

## Troubleshoot

```
:checkhealth nyanvim
```

## Performance

Startup time is benchmarked on every release using `nvim --startuptime`.

Results live in [`docs/perf/`](docs/perf/) — one file per release, with mean/median/min/max and a comparison against the previous release.

**Run locally:**
```bash
./bench.sh --runs 10
```

Results are saved to `docs/perf/YYYY-MM-DD-VERSION.md`.
