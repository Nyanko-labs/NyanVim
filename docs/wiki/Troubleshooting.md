# Troubleshooting

Start with `:NyanHealth`. Then `:Lazy` for plugin errors and `:messages` for the last error text.

| Symptom | Fix |
|---------|-----|
| Icons are boxes or `?` | install a Nerd Font and select it in the terminal |
| Background is black, not blue-grey | the editor is transparent; set the terminal background to `#101a1f`, or make it opaque (see [Customizing](Customizing.md)) |
| No syntax colours in some language | `:TSInstall <lang>`; if that fails, install the `tree-sitter` CLI and a C compiler |
| "N treesitter parsers missing" at startup | same: install `tree-sitter`, restart |
| No completion / LSP for a language | `:Mason`, install the server; check `:LspInfo` in the buffer |
| `Space t h` shows an empty list | you typed in the prompt; press Esc, then `j`/`k` |
| `Space t` seems slow | `Space t` is a group (`t t` terminal, `t h` theme); which-key waits 300 ms for the second key |
| Startup is slow | `:Lazy profile` shows which plugin; `./bench.sh` measures |
| Plugins broke after an update | `:Lazy restore` puts back the pinned versions |
| Something in `lua/user/init.lua` broke startup | the red notification names the line; the rest of the config still loads |

Still stuck? Open an issue with `:NyanHealth`, `:messages` and `nvim --version`.
