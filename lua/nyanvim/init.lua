local M = {}

M.version = "1.2.0"

--- Check if an executable exists on PATH
---@param name string
---@return boolean
function M.has_executable(name)
  return vim.fn.executable(name) == 1
end

--- Check if nvim version meets minimum
---@param major integer
---@param minor integer
---@return boolean
function M.nvim_version_ok(major, minor)
  local v = vim.version()
  return v.major > major or (v.major == major and v.minor >= minor)
end

local config_dir = vim.fn.stdpath("config")
M.user_config = config_dir .. "/lua/user/init.lua"

--- git pull the config, then sync plugins (LunarVim's :LvimUpdate)
function M.update()
  vim.notify("NyanVim: pulling " .. config_dir .. " …")
  vim.system(
    { "git", "-C", config_dir, "pull", "--ff-only" },
    {},
    vim.schedule_wrap(function(r)
      if r.code ~= 0 then
        return vim.notify("NyanVim update failed:\n" .. r.stderr, vim.log.levels.ERROR)
      end
      vim.notify("NyanVim: " .. vim.trim(r.stdout))
      require("lazy").sync({ wait = false })
    end)
  )
end

--- open (creating from the example on first use) the personal override file
function M.edit_user_config()
  if vim.fn.filereadable(M.user_config) == 0 then
    vim.fn.mkdir(vim.fs.dirname(M.user_config), "p")
    vim.fn.writefile(vim.fn.readfile(M.user_config .. ".example"), M.user_config)
    vim.notify("NyanVim: created " .. M.user_config)
  end
  vim.cmd.edit(M.user_config)
end

function M.setup()
  local cmd = vim.api.nvim_create_user_command
  cmd("NyanUpdate", M.update, { desc = "Update NyanVim (git pull + Lazy sync)" })
  cmd("NyanHealth", "checkhealth nyanvim", { desc = "Check NyanVim requirements" })
  cmd("NyanConfig", M.edit_user_config, { desc = "Edit your personal overrides" })
  -- personal overrides: lua/user/init.lua is git-ignored, so updates never touch it
  pcall(require, "user")
end

return M
