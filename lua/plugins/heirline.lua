local conditions = require("heirline.conditions")
--local utils = require("heirline.utils")

local WinBar = require "plugins.heirline.winbar"
local TabLine = require "plugins.heirline.tabline"
--local StatusLine = require "plugins.heirline.statusline"
local colors = require "plugins.heirline.components".colors
local M = {
    --statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    --statuscolumn = {

    --},
    opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
            return conditions.buffer_matches({
                buftype = { "terminal", "nofile", "prompt", "help", "quickfix" },
                filetype = { "aerial", "neo%-tree", "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
        end,
        colors = colors,
    },
}

return M
