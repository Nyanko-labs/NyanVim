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
| `Space *` | grep whole word under cursor |
| `Ctrl p`, `Ctrl f`, `Ctrl e` | VSCode-style: files, search in file, recent |

## Explorer, windows, buffers

| Key | Action |
|-----|--------|
| `Ctrl b` / `Space e` | toggle nvim-tree (right side) |
| `Ctrl h j k l` | move between windows |
| `Ctrl arrows` | resize |
| `Alt 1..4` | jump to window N |
| `Shift h` / `Shift l` | previous / next buffer |
| `Space b d` / `b o` / `b p` | delete / close others / pick buffer |
| `Ctrl x 2`, `Ctrl x 3`, `Ctrl x 0` | split (smart), vsplit, close |

## Code and LSP — `Space c`

| Key | Action |
|-----|--------|
| `g d` / `g D` / `g i` / `g r` | definition / declaration / implementation / references |
| `K` | hover docs |
| `Space r n` | rename |
| `Space c a` | code action |
| `Space c f` | format (conform, LSP fallback) |
| `Space c m` | Mason |

## Git — `Space g`

| Key | Action |
|-----|--------|
| `Space g g` | LazyGit |
| `Space g d` | Diffview |
| `Space g s` / `g b` / `g c` | status / branches / commits (Telescope) |

## Project, terminal, theme

| Key | Action |
|-----|--------|
| `Space p p` | switch project |
| `Space p f` | git files |
| `Space p t` | TODO comments |
| `Space t t` / `Ctrl \` | floating terminal |
| `Space t h` | theme picker |

## AI — `Space a` / `Space o`

| Key | Action |
|-----|--------|
| `Space a c` | toggle Claude Code split |
| `Space a s` (visual) | send selection to Claude |
| `Space a b` | add current buffer to Claude's context |
| `Space a a` / `Space a d` | accept / deny Claude's diff |
| `Space a g` | local LLM prompt (Ollama) |
| `Space o a` / `Space o o` | ask opencode / opencode menu |

## NyanVim — `Space n`

| Key | Action |
|-----|--------|
| `Space n u` | `:NyanUpdate` |
| `Space n h` | `:NyanHealth` |
| `Space n c` | `:NyanConfig` — your overrides |
| `Space n k` | keymaps cheatsheet |
| `Space n l` / `n m` | Lazy / Mason |
| `Space n t` | theme picker |

## Editing

| Key | Action |
|-----|--------|
| `<` / `>` (visual) | indent and keep selection |
| `J` / `K` (visual) | move lines |
| `Space w` / `Space q` / `Space Q` | save / quit / quit all |
| `Space h` | clear search highlight |
| `g c` | comment (Comment.nvim) |
