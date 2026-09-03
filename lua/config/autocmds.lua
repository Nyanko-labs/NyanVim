local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("General", { clear = true })

autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("VimResized", {
  group = general,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("FileType", {
  group = general,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("BufWritePre", {
  group = general,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

local lsp = augroup("LSP", { clear = true })

autocmd("CursorHold", {
  group = lsp,
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
  end,
})

-- Transparency lives in the colorscheme config (plugins/colorscheme.lua),
-- not here: the theme's transparent option replaces the old bg-clearing hack.

local treesitter_group = augroup("TreesitterWindow", { clear = true })

autocmd("FileType", {
  group = treesitter_group,
  pattern = "nvim-treesitter-playground",
  callback = function(event)
    vim.cmd("wincmd L")
    vim.cmd("vertical resize 40")
    vim.cmd("set winfixwidth")
  end,
})

autocmd("VimEnter", {
  group = augroup("WindowOptimize", { clear = true }),
  callback = function()
    vim.cmd("wincmd =")
  end,
})

local function smart_split()
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  if width > 2 * height then
    return "vertical split"
  else
    return "split"
  end
end

vim.api.nvim_create_user_command("SmartSplit", function()
  vim.cmd(smart_split())
end, {})

-- Tree position/width live in nvim-tree's own view config (lua/plugins/ui.lua)

autocmd("BufEnter", {
  group = augroup("NvimTreePyCharmBehavior", { clear = true }),
  callback = function()
    -- nvim-tree is lazy: only require it for a directory arg or when it is
    -- already open, so plain file edits don't load it.
    if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 then
      require("nvim-tree.api").tree.open()
    elseif package.loaded["nvim-tree"] and require("nvim-tree.api").tree.is_visible() then
      require("nvim-tree.api").tree.find_file({ open = true, focus = false })
    end
  end,
})

autocmd("FileType", {
  pattern = "dashboard",
  callback = function()
    if package.loaded["nvim-tree"] then
      require("nvim-tree.api").tree.close()
    end
    vim.opt_local.modifiable = false
    vim.opt_local.bufhidden = "wipe"
  end,
})
