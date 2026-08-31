return {
  -- opencode CLI in the editor (needs `opencode` on PATH)
  {
    "NickvanDyke/opencode.nvim",
    version = "*",
    config = function()
      vim.g.opencode_opts = {}
    end,
  },
  -- local LLM via ollama (needs the ollama service + a pulled model)
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "qwen2.5-coder:7b",
      display_mode = "float",
      result_filetype = "markdown",
    },
  },
}
