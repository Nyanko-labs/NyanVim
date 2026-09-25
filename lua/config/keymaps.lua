-- Single owner of every global keymap. config/which-key.lua only adds group
-- labels; nvim-tree's buffer-local maps live in its on_attach (plugins/ui.lua).
local map = vim.keymap.set

-- Window navigation
-- <C-h/j/k/l> window moves come from vim-tmux-navigator (editor.lua): same keys cross tmux panes
map("n", "<M-1>", "1<C-w>w", { desc = "Go to window 1" })
map("n", "<M-2>", "2<C-w>w", { desc = "Go to window 2" })
map("n", "<M-3>", "3<C-w>w", { desc = "Go to window 3" })
map("n", "<M-4>", "4<C-w>w", { desc = "Go to window 4" })

-- Window resize
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Editing
-- keep the cursor line centred after a half-page jump or a search hit
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next match" })
map("n", "N", "Nzzzv", { desc = "Previous match" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- File operations
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qall<cr>", { desc = "Quit all" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- Buffers (bufferline)
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
map("n", "<leader>br", "<cmd>BufferLineCloseRight<cr>", { desc = "Close buffers to the right" })
map("n", "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close buffers to the left" })

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "K", function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Show hover" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })

-- Code
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>co", function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" }, diagnostics = {} }, apply = true })
end, { desc = "Organize imports" })
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format code" })

-- File (telescope)
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true })
end, { desc = "Find files" })
map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" }
    end,
  })
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
  require("telescope.builtin").buffers({
    sort_mru = true,
    ignore_current_buffer = true,
  })
end, { desc = "Find buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps (cheatsheet)" })
map("n", "<leader>fy", "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", { desc = "Yank history" })

-- Search
map("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Search current word" })
map("n", "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search buffer" })
map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
map("n", "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace symbols" })
map("n", "<leader>*", function()
  require("telescope.builtin").grep_string({
    word_match = "-w",
    search = vim.fn.expand("<cword>"),
    initial_mode = "normal",
  })
end, { desc = "Search word under cursor" })

-- Project
map("n", "<leader>pf", "<cmd>Telescope git_files<cr>", { desc = "Find file" })
map("n", "<leader>pp", "<cmd>Telescope projects<cr>", { desc = "Switch project" })
map("n", "<leader>pt", "<cmd>TodoTelescope<cr>", { desc = "Todo list" })

-- Git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view" })
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Explorer (nvim-tree)
-- side and width come from nvim-tree's view config (plugins/ui.lua)
map("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle Explorer" })

-- Toggle / Theme
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("n", "<leader>tf", function()
  vim.g.nyanvim_autoformat = not vim.g.nyanvim_autoformat
  vim.notify("Format on save: " .. (vim.g.nyanvim_autoformat and "on" or "off"))
end, { desc = "Toggle format on save" })
map("n", "<leader>th", function()
  require("nyanvim.theme").pick()
end, { desc = "Theme picker" })
map("t", "<C-\\>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- opencode (AI group, next to Claude and the local model)
map({ "n", "x" }, "<leader>ao", function()
  require("opencode").ask("@this: ")
end, { desc = "Ask opencode" })
map({ "n", "x" }, "<leader>ap", function()
  require("opencode").select()
end, { desc = "opencode menu" })

map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Keymaps for this buffer" })

-- NyanVim menu (LunarVim's <leader>L, doom's <leader>h)
map("n", "<leader>nu", "<cmd>NyanUpdate<cr>", { desc = "Update NyanVim" })
map("n", "<leader>nh", "<cmd>NyanHealth<cr>", { desc = "Health check" })
map("n", "<leader>nc", "<cmd>NyanConfig<cr>", { desc = "Edit my overrides (lua/user)" })
map("n", "<leader>nl", "<cmd>Lazy<cr>", { desc = "Plugin manager" })
map("n", "<leader>nm", "<cmd>Mason<cr>", { desc = "LSP/tool installer" })

-- Local LLM (ollama via gen.nvim)
map({ "n", "v" }, "<leader>ag", "<cmd>Gen<cr>", { desc = "Local LLM (ollama)" })
