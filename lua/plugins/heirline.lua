local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
-- The easy way.
local Navic = {
    condition = function() return require("nvim-navic").is_available() end,
    provider = function()
        return require("nvim-navic").get_location({highlight=true})
    end,
    update = 'CursorMoved'
}

local M = {
    --statusline = {
    --},
    winbar = {
        Navic,
    },
    --tabline = {
    --},
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
    },
}

return M
