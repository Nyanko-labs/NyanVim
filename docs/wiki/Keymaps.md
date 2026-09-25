# Keymaps

Leader is **Space**. Press it and wait: which-key lists the groups. `Space f k` fuzzy-searches every mapping by description. All global maps live in one file, `lua/config/keymaps.lua`.

## Files and search — `Space f` / `Space s`

| Key | Action |
|-----|--------|
| `Space f f` | find files (hidden included, `.git`/`node_modules` skipped) |
| `Space f g` | live grep |
| `Space f b` | open buffers |
| `Space f r` | recent files |
| `Space f h` | help tags |
| `Space f k` | keymaps cheatsheet |
| `Space f y` | yank history |
| `Space s w` | grep the word under the cursor |
| `Space s b` | search in the current buffer |
| `Space s s` / `Space s S` | document / workspace symbols |
| `Space s r` | resume the last picker |
| `Space *` | grep whole word under cursor |

## Explorer, windows, buffers

| Key | Action |
|-----|--------|
| `Space e` / `Space e` | toggle nvim-tree (right side) |
| `Ctrl h j k l` | move between windows |
| `Ctrl arrows` | resize |
| `Alt 1..4` | jump to window N |
| `Shift h` / `Shift l` | previous / next buffer |
| `Space b d` / `b o` / `b p` | delete / close others / pick buffer |
| `Space ?` | every mapping active in this buffer |
| `Ctrl h/j/k/l` | move between splits, and tmux panes |
| `s` / `S` | flash jump / treesitter select |
| `g s a` / `g s d` / `g s r` | surround add / delete / replace |

## Code and LSP — `Space c`

| Key | Action |
|-----|--------|
| `g d` / `g D` / `g i` / `g r` | definition / declaration / implementation / references |
| `K` | hover docs |
| `Space c r` | rename |
| `Space c a` | code action |
| `Space c f` | format (conform, LSP fallback) |
| `Space c o` | organize imports |
| `Space c d` / `Space c s` | diagnostics list / symbols outline (Trouble) |
| `[d` / `]d` | previous / next diagnostic (Neovim default) |

## Git — `Space g`

| Key | Action |
|-----|--------|
| `Space g g` | LazyGit |
| `Space g d` | Diffview |
| `Space g s` / `g b` / `g c` | status / branches / commits |
| `]h` / `[h` | next / previous hunk |
| `Space g p` / `g a` / `g r` | preview / stage / reset hunk |

## Project, terminal, theme

| Key | Action |
|-----|--------|
| `Space p p` | switch project |
| `Space p f` | git files |
| `Space p t` | TODO comments |
| `Space t t` / `Ctrl \` | floating terminal |
| `Space t f` | toggle format on save |
| `Space t h` | theme picker |

## AI — `Space a`

| Key | Action |
|-----|--------|
| `Space a c` | toggle Claude Code split |
| `Space a s` (visual) | send selection to Claude |
| `Space a b` | add current buffer to Claude's context |
| `Space a a` / `Space a d` | accept / deny Claude's diff |
| `Space a g` | local LLM prompt (Ollama) |
| `Space a o` / `Space a p` | ask opencode / opencode menu |

## NyanVim — `Space n`

| Key | Action |
|-----|--------|
| `Space n u` | `:NyanUpdate` |
| `Space n h` | `:NyanHealth` |
| `Space n c` | `:NyanConfig` — your overrides |
| `Space n l` / `n m` | Lazy / Mason |

## Editing

| Key | Action |
|-----|--------|
| `<` / `>` (visual) | indent and keep selection |
| `J` / `K` (visual) | move lines |
| `Space w` / `Space q` / `Space Q` | save / quit / quit all |
| `Space h` | clear search highlight |
| `g c` | comment (Comment.nvim) |
