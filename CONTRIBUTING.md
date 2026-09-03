# Contributing to NyanVim

Thanks for helping. NyanVim is deliberately small (~1,200 lines of Lua), so the
bar for a change is "does this make the editor better for a new user without
making the config harder to read?".

## Set up a dev copy

Work on a side-by-side install so your daily config keeps working:

```bash
git clone https://github.com/<you>/NyanVim.git ~/.config/nyanvim
NVIM_APPNAME=nyanvim nvim            # plugins install on first launch
```

Everything under `NVIM_APPNAME=nyanvim` (plugins, data, cache) is separate from
your `~/.config/nvim`. `~/.config/nyanvim/uninstall.sh --try` removes it again.

## How the config is organised

| Path | Rule |
|------|------|
| `lua/plugins/*.lua` | One concern per file, one lazy.nvim spec list per file. Every plugin declares `event`, `cmd`, `keys` or `ft`; only the colorscheme, snacks, treesitter and the dashboard load eagerly. |
| `lua/config/keymaps.lua` | The **only** place global keymaps are set. Plugin `keys = {}` tables and buffer-local `on_attach` maps are fine; `vim.keymap.set` anywhere else is not. |
| `lua/config/which-key.lua` | Group labels only, no mappings. |
| `lua/plugins/colorscheme.lua` | Owns transparency and the theme. No highlight hacks in autocmds. |
| `lua/nyanvim/` | NyanVim's own code: `:Nyan*` commands, health, theme picker, discipline. |
| `lua/user/` | The user's overrides. Git-ignored; NyanVim never writes here except to create `init.lua` from the example. |

Adding a plugin: new file in `lua/plugins/`, lazy handler required, `opts = {}`
over a `config` function when possible, a one-line comment saying why it exists.

Adding a language: LSP server in `ensure_installed` (`lua/plugins/lsp.lua`),
parser in the `ensure` list (`lua/plugins/treesitter.lua`), formatter in
`formatters_by_ft` (`lua/plugins/conform.lua`). All three or none.

## Before you open a pull request

```bash
stylua --check lua init.lua                       # formatting (stylua.toml)
nvim --headless -c 'lua print(vim.v.errmsg)' -c qa!   # starts clean, prints nothing
NVIM_APPNAME=nyanvim nvim -c NyanHealth           # no errors
./bench.sh --runs 10                              # startup did not regress
```

If you touched anything visible, retake the screenshots with
`scripts/capture-screenshots.sh` (macOS: wezterm + screencapture) and update
the README tables.

Plugin versions are pinned in `lazy-lock.json`. If your change needs a newer
plugin, run `:Lazy update <plugin>`, test, and commit the lockfile change in the
same PR with a note saying why.

## Commit messages

Conventional commits, lower-case, imperative:

```
feat(theme): add live preview to the picker
fix: guard nil entry when the picker list is empty
docs: retake screenshots
perf: benchmark results for v1.3.0
chore: bump lockfile for nvim-treesitter
```

One logical change per commit. The body says *why*, the diff already says what.

## Reporting a bug

Open an issue with the output of `:NyanHealth`, `:messages`, and
`nvim --version`. If it is a startup problem, `nvim --startuptime /tmp/st.log`
and attach the log.

## Releasing (maintainers)

```bash
./bench.sh --runs 10 --version vX.Y.Z    # writes docs/perf/<date>-vX.Y.Z.md
# bump M.version in lua/nyanvim/init.lua, update the "Latest" link in README
git commit -am "perf: benchmark results for vX.Y.Z"
git tag -a vX.Y.Z -m "NyanVim vX.Y.Z — <one line>"
git push origin main vX.Y.Z
```
