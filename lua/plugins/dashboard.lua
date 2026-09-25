local cfg = vim.fn.stdpath("config")

return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  opts = {
    theme = "doom",
    config = {
      header = {
        "                                                                    ",
        "  ███╗   ██╗██╗   ██╗ █████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗  ",
        "  ████╗  ██║╚██╗ ██╔╝██╔══██╗████╗  ██║██║   ██║██║████╗ ████║  ",
        "  ██╔██╗ ██║ ╚████╔╝ ███████║██╔██╗ ██║██║   ██║██║██╔████╔██║  ",
        "  ██║╚██╗██║  ╚██╔╝  ██╔══██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
        "  ██║ ╚████║   ██║   ██║  ██║██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
        "  ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
        "                                                                    ",
        "        /\\_/\\  ≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋           ",
        "       ( ^.^ ) ██████████████████████████████████████           ",
        "        > ^ <  ██ ♥ ★ ♥ ★ ♥ ★ ♥ ★ ♥ ★ ♥ ★ ♥ ★ ♥ ██           ",
        "       /|   |\\  ██████████████████████████████████████           ",
        "      (_|   |_) ≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋≋           ",
        "                                                                    ",
      },
      center = {
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Find File",
          desc_hl = "String",
          key = "f",
          key_hl = "Number",
          action = "FzfLua files",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Recent Files",
          desc_hl = "String",
          key = "r",
          key_hl = "Number",
          action = "FzfLua oldfiles",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Find Word",
          desc_hl = "String",
          key = "w",
          key_hl = "Number",
          action = "FzfLua live_grep",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "New File",
          desc_hl = "String",
          key = "n",
          key_hl = "Number",
          action = "enew",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Keymaps",
          desc_hl = "String",
          key = "k",
          key_hl = "Number",
          action = "FzfLua keymaps",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Theme",
          desc_hl = "String",
          key = "t",
          key_hl = "Number",
          action = "lua require('nyanvim.theme').pick()",
        },
        {
          icon = " ",
          icon_hl = "Title",
          desc = "Quit",
          desc_hl = "String",
          key = "q",
          key_hl = "Number",
          action = "qa",
        },
      },
      footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local data = vim.fn.stdpath("data")
        local mason = #vim.fn.globpath(data .. "/mason/bin", "*", false, true)
        local parsers = #vim.fn.globpath(data .. "/site/parser", "*.so", false, true)
        local lines = {
          "",
          "[lazy.nvim ]  " .. stats.loaded .. "/" .. stats.count .. " plugins · " .. ms .. "ms",
          "[mason     ]  " .. mason .. " tools armed",
          "[treesitter]  " .. parsers .. " parsers compiled",
          "[nyanvim   ]  ready.  > ^ <",
        }
        -- the doom theme centers each line separately; right-pad to equal
        -- width so the bracket columns stay aligned
        local width = 0
        for _, l in ipairs(lines) do
          width = math.max(width, #l)
        end
        for i, l in ipairs(lines) do
          lines[i] = l .. string.rep(" ", width - #l)
        end
        return lines
      end,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
