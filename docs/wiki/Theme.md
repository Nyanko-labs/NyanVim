# Theme

NyanVim ships [nightcity.nvim](https://github.com/kyuna0312/nightcity.nvim), the Neovim side of [night-city-palettes](https://github.com/kyuna0312/night-city-palettes). Four styles:

| Style | Character |
|-------|-----------|
| `mix` (default) | Night City Mix: gamma-correct blend of the other three, blue-grey ground with a neon pop |
| `boxuk` | Box UK Contrast, calmer, higher contrast |
| `lucy` | Cyberpunk Lucy, more neon |
| `osaka` | Solarized Osaka |

## Switching

`Space t h` opens the picker. `j`/`k` preview the whole UI live, Enter keeps the choice, Esc puts the previous theme back. The choice is saved to `~/.local/share/nvim/nyanvim-theme` and loaded on the next start. To force one in `lua/user/init.lua`: `vim.cmd.colorscheme("nightcity-lucy")`.

## Transparency and the terminal

The editor background is transparent; the terminal supplies the colour. For the intended look set your terminal background to `#101a1f`. Ready-made terminal palettes (Ghostty, kitty, WezTerm, Alacritty, tmux) for every style are in the `extras/` folder of night-city-palettes. Prefer an opaque editor? See [Customizing](Customizing.md) — one line.

## The palette

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
