-- load configs
require("config")
-- lazy configurations
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- load lazy plugins
require("plugins")

------------------------------------- colorscheme -----------------------------------------
local theme = require("env").ui.theme
if theme then
    require(theme.name).load()
    vim.opt.background = require("env").ui.theme.style
end

