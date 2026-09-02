return {
  -- opencode CLI in the editor (needs `opencode` on PATH); loads on first require
  { "NickvanDyke/opencode.nvim", version = "*", lazy = true },
  -- local LLM via ollama (needs the ollama service + a pulled model)
  {
    "David-Kunz/gen.nvim",
    cmd = "Gen",
    opts = {
      model = "qwen2.5-coder:7b",
      display_mode = "float",
      result_filetype = "markdown",
    },
  },
}
