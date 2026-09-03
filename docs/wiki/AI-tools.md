# AI tools

All optional. Nothing here needs an API key in the config.

## Claude Code — `Space a`

[claudecode.nvim](https://github.com/coder/claudecode.nvim) runs the Claude Code CLI in a split. Needs `claude` on your PATH.

- `Space a c` toggle the split, `Space a f` focus it
- `Space a s` in visual mode sends the selection; `Space a b` adds the current buffer; `Space a t` adds the file under the cursor in nvim-tree
- `Space a a` / `Space a d` accept or deny a diff Claude proposes
- `Space a r` / `Space a C` resume or continue a session, `Space a m` pick a model

## opencode — `Space o`

[opencode.nvim](https://github.com/NickvanDyke/opencode.nvim) drives the opencode CLI. `Space o a` asks about the current context, `Space o o` opens its menu.

## Local model — `Space a g`

[gen.nvim](https://github.com/David-Kunz/gen.nvim) talks to a local [Ollama](https://ollama.com):

```bash
brew install ollama && brew services start ollama
ollama pull qwen2.5-coder:7b
```

Change the model in `lua/user/plugins/ai.lua`: `{ "David-Kunz/gen.nvim", opts = { model = "llama3.1" } }`.
