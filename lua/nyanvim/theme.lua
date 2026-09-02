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
  local pickers, finders = require("telescope.pickers"), require("telescope.finders")
  local conf = require("telescope.config").values
  local actions, action_state = require("telescope.actions"), require("telescope.actions.state")
  local action_set = require("telescope.actions.set")
  local previous, chosen = vim.g.colors_name, nil

  pickers
    .new(require("telescope.themes").get_dropdown({ previewer = false }), {
      prompt_title = "NyanVim theme",
      finder = finders.new_table(M.styles),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(bufnr)
        action_set.shift_selection:enhance({
          post = function()
            vim.cmd.colorscheme("nightcity-" .. action_state.get_selected_entry()[1])
          end,
        })
        actions.select_default:replace(function()
          chosen = action_state.get_selected_entry()[1]
          actions.close(bufnr)
        end)
        actions.close:enhance({
          post = function()
            if chosen then
              M.apply(chosen)
            else
              vim.cmd.colorscheme(previous)
            end
          end,
        })
        return true
      end,
    })
    :find()
end

return M
