local opt = vim.opt
local g = vim.g

------------------------------------- leader key -----------------------------------------
g.mapleader = ","
-------------------------------------- globals -----------------------------------------
-- dracula
-- onedark
-- tokyonight-moon/storm/night/day
-- catppuccin-macchiato/mocha/frappe/latte
-- gruvbox-material
-- nordic
-- nightfox
-- sonokai
-- github_dark/_light
-- newpaper (using light)
g.theme = "github_dark"
g.background = "dark"
g.transparency = false
g.lsp_semantic_tokens = false -- dim unused code

-------------------------------------- options ------------------------------------------
--vim.o.winborder = "rounded"  -- it is too ugly
opt.laststatus = 3 -- global statusline
opt.showmode = true

opt.clipboard = "unnamedplus"
opt.cursorline = true

opt.tags = { ".tag", ".tags", "tags" }
-- Indenting
opt.expandtab = false
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

opt.showmatch = true
opt.wildmode = "list:longest,full"
opt.scrolljump = 5
opt.scrolloff = 3

opt.autochdir = true

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
opt.whichwrap:append("bs<>[]hl")
opt.wrap = false

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"

-- beancount path configure
local root_dir = vim.fn.stdpath("config")
local custom = vim.fn.expand(root_dir .. "/lua/custom.lua")
if vim.fn.filereadable(custom) == 1 then
	vim.g.beancount_file = require("custom").get_beancount()
else
	vim.g.beancount_file = nil
end

-- add extra filetype
-- reference: https://neovim.io/doc/user/lua.html#vim.filetype.add()
vim.filetype.add({
	filename = {
		["SConscript"] = "python",
	},
})
-- intent
local function intent_toggle()
	if vim.bo.expandtab then
		opt.expandtab = false
		vim.notify("Switched to TAB indent", vim.log.levels.INFO, { title = "Indent" })
	else
		opt.expandtab = true
		vim.notify("Switched to SPACE indent", vim.log.levels.INFO, { title = "Indent" })
	end
end
-- user command
vim.api.nvim_create_user_command("IndentToggle", function() intent_toggle() end, {})

-------------------------------------- treesitter ------------------------------------------
-- Enable treesitter-based highlighting for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"vim", "lua",
		"html", "css", "javascript", "typescript", "tsx",
		"c", "cpp", "python", "bash", "diff",
		"json", "yaml", "markdown",
		"make", "cmake", "gitcommit", "beancount",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

-- Enable treesitter-based indentation (experimental)
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"lua", "javascript", "typescript", "tsx",
		"c", "cpp", "python", "bash",
		"json", "yaml",
	},
	callback = function()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-------------------------------------- do functions ------------------------------------------
require("mappings").general_mapping()
