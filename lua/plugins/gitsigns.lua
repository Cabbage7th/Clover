local M = {}

M.gitsigns = {
	signs = {
		add = { hl = "DiffAdd", text = "+", numhl = "GitSignsAddNr" },
		change = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
		delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
		topdelete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
		changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
		untracked = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},
	current_line_blame = true,
	on_attach = function(bufnr)
		require("mappings").gitsigns(bufnr)
	end,
}

return M
