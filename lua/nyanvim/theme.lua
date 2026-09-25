-- NvChad-style theme switcher over the nightcity styles. Moving in the picker
-- previews live, <CR> commits, <Esc> restores. The choice persists in
-- stdpath("data")/nyanvim-theme so it survives restarts.
local M = {}

M.styles = { "mix", "boxuk", "lucy", "osaka" }
local file = vim.fn.stdpath("data") .. "/nyanvim-theme"

---@return string? style saved by a previous pick
function M.saved()
  local f = io.open(file)
  if not f then
    return nil
  end
  local style = f:read("*l")
  f:close()
  return vim.tbl_contains(M.styles, style) and style or nil
end

---@param style string
function M.apply(style)
  vim.cmd.colorscheme("nightcity-" .. style)
  local f = assert(io.open(file, "w"))
  f:write(style)
  f:close()
end

function M.pick()
  local previous, chosen = vim.g.colors_name, nil

  -- fzf-lua asks the previewer to fill its buffer for every highlighted entry:
  -- that hook is the live preview, the buffer just shows a sample
  local Preview = require("fzf-lua.previewer.builtin").base:extend()
  function Preview:new(o, opts, fzf_win)
    Preview.super.new(self, o, opts, fzf_win)
    setmetatable(self, Preview)
    return self
  end
  function Preview:populate_preview_buf(entry)
    vim.cmd.colorscheme("nightcity-" .. entry)
    local buf = self:get_tmp_buffer()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      "-- nightcity-" .. entry,
      'local greet = function(name) return "hi " .. name end',
      "for i = 1, 3 do print(greet(i)) end",
    })
    vim.bo[buf].filetype = "lua"
    self:set_preview_buf(buf)
  end
  function Preview:close()
    if not chosen then
      vim.cmd.colorscheme(previous) -- Esc, or the window closed without a pick
    end
    Preview.super.close(self)
  end

  require("fzf-lua").fzf_exec(M.styles, {
    prompt = "Theme> ",
    previewer = {
      _ctor = function()
        return Preview
      end,
    },
    winopts = { height = 0.4, width = 0.5, preview = { layout = "vertical", vertical = "down:45%" } },
    fzf_opts = { ["--header"] = "j/k preview · ⏎ keep · esc cancel", ["--layout"] = "reverse-list" },
    actions = {
      ["enter"] = function(selected)
        chosen = selected[1]
        M.apply(chosen)
      end,
    },
  })
end

return M
