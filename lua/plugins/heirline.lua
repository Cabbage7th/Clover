local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local WinBar = require "plugins.heirline.winbar"
local TabLine = require "plugins.heirline.tabline"
--local StatusLine = require "plugins.heirline.statusline"
local colors = require "plugins.heirline.components".colors

-- configure color first
local setup_colors = colors
require("heirline").load_colors(setup_colors)
require("heirline").setup({
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
    },
})
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        utils.on_colorscheme(setup_colors)
    end,
    group = "Heirline",
})


-- Yep, with heirline we're driving manual!
vim.o.showtabline = 2   -- show tabline always
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

