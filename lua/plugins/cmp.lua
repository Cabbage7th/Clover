local cmp = require("cmp")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

local cmp_fields = {
	default = { "abbr", "kind", "menu" },
	atom = { "kind", "abbr", "menu" },
}

local formatting_style = {

	fields = cmp_fields[vim.g.cmp_style] or { "abbr", "kind", "menu" },

	format = function(_, item)
		local icons = require("icons").lspkind
		local icon = icons[item.kind]

		if vim.g.cmp_style == "atom" then
			icon = " " .. icon .. " "
			item.menu = "   (" .. item.kind .. ")"
			item.kind = icon
		else
			icon = " " .. icon .. " "
			item.kind = string.format("%s %s", icon, item.kind)
		end
		return item
	end,
}

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

cmp.setup({
	completion = {
		completeopt = "menu,menuone",
	},

	window = {
		completion = {
			side_padding = 1,
			winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
			border = border("Border"),
			scrollbar = false,
		},
		documentation = {
			border = border("DocBorder"),
			winhighlight = "Normal:Doc",
		},
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = formatting_style,

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "codeium" },
		{ name = "beancount", option = {
			account = vim.g.beancount_file,
		} },
		{
			per_filetype = {
				codecompanion = { "codecompanion" },
			}
		},
	}),
})
-- for cmd-line
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
			{
				name = 'cmdline',
				option = {
					ignore_cmds = { 'Man', '!' }
				}
			}
		})
})
-- `/` cmdline setup.
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
