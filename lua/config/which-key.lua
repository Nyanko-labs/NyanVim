-- which-key is a pure labeling adapter: all real keymaps live in
-- config/keymaps.lua, this file only names the leader groups.
local wk = require("which-key")

wk.setup({
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
  win = {
    border = "single",
    padding = { 2, 2 },
  },
  show_help = true,
})

wk.add({
  { "<leader>a", group = "AI" },
  { "<leader>b", group = "Buffer" },
  { "<leader>o", group = "opencode" },
  { "<leader>c", group = "Code" },
  { "<leader>f", group = "File" },
  { "<leader>g", group = "Git" },
  { "<leader>n", group = "NyanVim" },
  { "<leader>p", group = "Project" },
  { "<leader>s", group = "Search" },
  { "<leader>t", group = "Toggle/Theme" },
})
