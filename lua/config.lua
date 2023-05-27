local opt = vim.opt
local g = vim.g

------------------------------------- leader key -----------------------------------------
g.mapleader = ","
-------------------------------------- globals -----------------------------------------
--
-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.tags = {'.tag', '.tags', 'tags'}
-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.list = true

vim.opt.listchars = {
    tab = "› ",
    --eol = "⤶",
    space = " ",
    trail = "•",
    extends = "◀",
    precedes = "▶",
    nbsp = ".",
}

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

-- disable nvim intro
opt.shortmess:append("sIcm")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
opt.wrap = false

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"

-------------------------------------- do functions ------------------------------------------
require("mappings").general_mapping()
