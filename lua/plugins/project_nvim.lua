require("project_nvim").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	-- Manual mode doesn't automatically change your root directory, so you have
	-- the option to manually do so using `:ProjectRoot` command.
	manual_mode = false,

	-- Methods of detecting the root directory. **"lsp"** uses the native neovim
	-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
	-- order matters: if one is not detected, the other is used as fallback. You
	-- can also delete or rearangne the detection methods.
	--detection_methods = { "lsp", "pattern" },
	detection_methods = { "pattern" },

	-- All the patterns used to detect root dir, when **"pattern"** is in
	-- detection_methods
	patterns = { ".tags", ".git", "_darcs", ".hg", ".bzr", ".svn", "package.json" },
})
require("telescope").load_extension("projects")
vim.keymap.set("n", "<leader>fp", "<cmd> Telescope projects <CR>")
