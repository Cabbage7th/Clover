local M = {
	options = {
		icons_enabled = true,
		theme = vim.g.theme,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "NvimTree" },
			--winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			--winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return "  " .. str
				end,
				separator = { left = "" },
				right_padding = 2,
			},
		},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = {
			{
				"location",
				separator = { right = "" },
				left_padding = 2,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	--tabline = {},
	--winbar = {
	--lualine_a = {},
	--lualine_b = {},
	--lualine_c = {},
	--lualine_x = {},
	--lualine_y = {},
	--lualine_z = {}
	--},
	--inactive_winbar = {
	--lualine_a = {},
	--lualine_b = {},
	--lualine_c = {},
	--lualine_x = {},
	--lualine_y = {},
	--lualine_z = {}
	--},
	extensions = {},
}

return M
