local M = {
	-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 'enter' for enter to accept
	-- 'none' for no mappings
	--
	-- All presets have the following mappings:
	-- C-space: Open menu or open docs if already open
	-- C-n/C-p or Up/Down: Select next/previous item
	-- C-e: Hide menu
	-- C-k: Toggle signature help (if signature.enabled = true)
	--
	-- See :h blink-cmp-config-keymap for defining your own keymap
	keymap = {
		preset = "enter",
		["<C-y>"] = { "select_and_accept" },
	},
	cmdline = {
		enabled = false,
		keymap = { preset = 'inherit' },
		completion = { menu = { auto_show = true } },
	},

	snippets = {
		--preset = "mini_snippets",
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = 'mono'
	},

	signature = {
		enabled = false,	-- using other signature
		window = { border = 'rounded' },
	},

	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			}
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = 'rounded' },
		},
		menu = {
			border = 'rounded',
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon", gap = 1},
					{ "label", "label_description", gap = 1 }, -- core info
					{ "source_name"},
				},
				components = {
					--source_name = {
						--text = function(ctx) return '(' .. ctx.text .. ')' end
					--}
				}
			}
		}
	},

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = {
			'lsp',
			'path',
			'snippets',
			'buffer',
			'codeium',
			--{
				--name = "beancount", option = {
					--account = vim.g.beancount_file,
				--}
			--},
		},
		per_filetype = {
			codecompanion = { "codecompanion" },
		},
		providers = {
			codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
			-- defaults to `{ 'buffer' }`
			lsp = { fallbacks = {} }
		},
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" },
}
return M
