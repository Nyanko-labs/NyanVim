local health = vim.health
local nyanvim = require("nyanvim")

local required_executables = {
  { name = "git", reason = "plugin manager (lazy.nvim)" },
  { name = "node", reason = "JS/TS and Python language servers (optional)", optional = true },
  { name = "npm", reason = "installing those servers (optional)", optional = true },
  { name = "rg", reason = "Telescope live grep" },
  { name = "fd", reason = "faster Telescope file search (optional)", optional = true },
  { name = "lazygit", reason = "LazyGit integration (optional)", optional = true },
  { name = "tree-sitter", reason = "Treesitter parser installs (nvim-treesitter main branch)" },
}

local function check_nvim_version()
  health.start("Neovim Version")
  if nyanvim.nvim_version_ok(0, 11) then
    health.ok(string.format("Neovim %s (>= 0.11 required)", tostring(vim.version())))
  else
    health.error(
      string.format("Neovim %s is too old. Upgrade to >= 0.11", tostring(vim.version())),
      { "https://github.com/neovim/neovim/releases" }
    )
  end
end

local function check_executables()
  health.start("External Dependencies")
  for _, dep in ipairs(required_executables) do
    if nyanvim.has_executable(dep.name) then
      health.ok(dep.name .. " - " .. dep.reason)
    elseif dep.optional then
      health.warn(dep.name .. " not found - " .. dep.reason)
    else
      health.error(
        dep.name .. " not found - required for: " .. dep.reason,
        { "Install via your package manager (brew/apt/pacman)" }
      )
    end
  end
end

local function check_c_compiler()
  health.start("C Compiler")
  local compilers = { "cc", "gcc", "clang" }
  local found = false
  for _, cc in ipairs(compilers) do
    if nyanvim.has_executable(cc) then
      health.ok(cc .. " found (needed for Treesitter parsers)")
      found = true
      break
    end
  end
  if not found then
    health.error(
      "No C compiler found (cc/gcc/clang). Treesitter parsers cannot be compiled.",
      { "Install build-essential (Debian), base-devel (Arch), or Xcode CLI tools (macOS)" }
    )
  end
end

local function check_nerd_font()
  health.start("Nerd Font")
  health.info("If icons look like boxes, set a Nerd Font in your terminal: https://www.nerdfonts.com/")
end

local M = {}

function M.check()
  check_nvim_version()
  check_executables()
  check_c_compiler()
  check_nerd_font()
end

return M
