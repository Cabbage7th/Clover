local options = {
	ensure_installed = {
		"vim",
		"lua",

		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",

		"c",
		"cpp",
		"python",
		"bash",
		"diff",

		"json",
		"yaml",
		"markdown",
		"markdown_inline",

		"make",
		"cmake",
		"gitcommit",
		"beancount",
	},
	highlight = {
		enable = true,
		use_languagetree = true,
		disable = function(_, bufnr)
			local buf_name = vim.api.nvim_buf_get_name(bufnr)
			local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
			return file_size > 1024 * 1024
		end,
	},

	indent = {
		enable = true,
		disable = function(_, bufnr)
			local buf_name = vim.api.nvim_buf_get_name(bufnr)
			local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
			return file_size > 1024 * 1024
		end,
	},
}

return options
