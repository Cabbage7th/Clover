local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Winbar components
local FileNameBlock = require("plugins.heirline.components").FileNameBlock
local WinBars = {
    fallthrough = false,
    {   -- A special winbar for terminals
        condition = function()
            return conditions.buffer_matches({ buftype = { "terminal" } })
        end,
        utils.surround({ "", "" }, "dark_red", {
            FileType,
            Space,
            TerminalName,
        }),
    },
    {   -- An inactive winbar for regular files
        condition = function()
            return not conditions.is_active()
        end,
        utils.surround({ "", "" }, "bright_bg", { hl = { fg = "gray", force = true }, FileNameBlock }),
    },
    -- A winbar for regular files
    utils.surround({ "", "" }, "bright_bg", FileNameBlock),
}

local components = require("plugins.heirline.components")

local M = {
    --WinBars,
    components.Navic,
}

return M 
