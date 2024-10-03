-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

	-- colorscheme
	{
		"navarasu/onedark.nvim",
		"folke/tokyonight.nvim",
		{ "catppuccin/nvim", name = "catppuccin" },
		"rebelot/kanagawa.nvim",
		"Mofiqul/dracula.nvim",
	},

	{
		"NvChad/nvterm",
		init = function()
			require("mappings").nvterm()
		end,
		config = function(_, opts)
			require("nvterm").setup(opts)
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		init = function()
			require("lazy").load({ plugins = "nvim-colorizer.lua" })
		end,
		config = function(_, opts)
			require("colorizer").setup(opts)

			-- execute colorizer as soon as possible
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		init = function()
			require("lazy").load({ plugins = "indent-blankline.nvim" })
		end,
		config = function()
			require("mappings").blankline()
			require("plugins.blankline")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("lazy").load({ plugins = "nvim-treesitter" })
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter",
			},
		},
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		opts = function()
			return require("plugins.gitsigns").gitsigns
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- lsp stuff
			{
				"williamboman/mason-lspconfig.nvim",
				lazy = false,
				dependencies = {
					{
						"williamboman/mason.nvim",
						build = ":MasonUpdate", -- :MasonUpdate updates registry contents
					},
				},
				config = function()
					require("plugins.mason")
				end,
			},
			{
				"ray-x/lsp_signature.nvim",
				config = function()
					require("lsp_signature").setup()
				end,
			},
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("nvim-navic").setup()
				end,
			},
		},
		init = function()
			require("lazy").load({ plugins = "nvim-lspconfig" })
		end,
		config = function()
			require("plugins.lspconfig")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
		config = function()
			require("plugins.none_ls")
		end,
	},

	-- load luasnips + cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				-- snippet plugin
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("plugins.luasnip").luasnip(opts)
				end,
			},

			-- autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"crispgm/cmp-beancount",
			},
			{
				"nvim-tree/nvim-web-devicons",
			},
		},
		config = function()
			require("plugins.cmp")
		end,
	},

	-- file managing , picker etc
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		lazy = false,
		init = function()
			require("mappings").nvimtree()
		end,
		opts = function()
			return require("plugins.nvimtree")
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
			vim.g.nvimtree_side = opts.view.side
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",

		init = function()
			require("mappings").telescope()
		end,

		config = function()
			require("plugins.telescope")
		end,
	},

	-- Only load whichkey after all the gui
	{
		"folke/which-key.nvim",
		keys = { "<leader>", '"', "'", "`", "c", "v" },
		init = function()
			require("mappings").whichkey()
		end,
		opts = function()
			return require("plugins.whichkey")
		end,
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		init = function()
			require("lazy").load({ plugins = "hop.nvim" })
		end,
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			require("mappings").hop()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
			},
		},
		init = function()
			require("lazy").load({ plugins = "lualine.nvim" })
		end,
		opts = function()
			return require("plugins.lualine")
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			require("lazy").load({ plugins = "bufferline.nvim" })
		end,
		opts = function()
			return require("plugins.bufferline")
		end,
		config = function(_, opts)
			require("bufferline").setup(opts)
			require("mappings").bufferline()
		end,
	},
	{
		"dhananjaylatkar/cscope_maps.nvim", -- cscope keymaps
		lazy = false,
		config = function()
			require("cscope_maps").setup({
				disable_maps = true, -- true disables my keymaps, only :Cscope will be loaded
				cscope = {
					db_file = "./cscope.out", -- location of cscope db file
					exec = "cscope", -- "cscope" or "gtags-cscope"
					db_build_cmd_args = { "-bqkv" }, -- args used for db build (:Cscope build)
					picker = "telescope", -- "telescope", "fzf-lua" or "quickfix"
					-- "true" does not open picker for single result, just JUMP
					skip_picker_for_single_result = false, -- "false" or "true"
					-- statusline indicator, default is cscope executable
					statusline_indicator = nil,
				},
			})
			require("mappings").cscope()
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		lazy = false,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({})
		end,
	},
	{
		"RaafatTurki/hex.nvim",
		lazy = false,
		config = function()
			require("hex").setup({})
		end,
	},
	{
		"utilyre/barbecue.nvim",
		lazy = false,
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("plugins.barbecue")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
		config = function()
			require("plugins.diffview")
		end,
	},
	-- dap not used now
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("plugins.project_nvim")
		end,
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>tt", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
		config = function()
			vim.g.codeium_disable_bindings = 1
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-e>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<M-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<M-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<c-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		event = "BufEnter",
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = false,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("plugins.lazygit")
		end,
	},
	{
		"folke/todo-comments.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.todo_comments")
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = function()
			-- add any opts here
			return require("plugins.avante")
		end,
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	---- vimscript plugins
	{
		"vim-scripts/DoxygenToolkit.vim",
		lazy = false,
	},
	{
		"liuchengxu/vista.vim",
		lazy = false,
	},
	{
		"rhysd/conflict-marker.vim",
		lazy = false,
		config = function()
			vim.cmd("nmap [x  <Cmd>ConflictMarkerPrevHunk<CR>")
			vim.cmd("nmap ]x  <Cmd>ConflictMarkerNextHunk<CR>")
		end,
	},
	{
		"mg979/vim-visual-multi",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		lazy = false,
	},
	{
		"azabiong/vim-highlighter",
		lazy = false,
		config = function()
			vim.cmd("nmap [h  <Cmd>Hi<<CR>")
			vim.cmd("nmap ]h  <Cmd>Hi><CR>")
		end,
	},
	{
		"scrooloose/nerdcommenter",
		lazy = false,
	},

	{
		"wellle/targets.vim",
		lazy = false,
	},
	{
		"nathangrigg/vim-beancount",
		lazy = false,
	},
	{
		"godlygeek/tabular",
		lazy = false,
		config = function()
			vim.cmd("nmap <Leader>a= <cmd>:Tabularize /=<CR>")
			vim.cmd("vmap <Leader>a= <cmd>:Tabularize /=<CR>")
			vim.cmd("nmap <Leader>a: <cmd>:Tabularize /:\zs<CR>")
			vim.cmd("vmap <Leader>a: <cmd>:Tabularize /:\zs<CR>")
		end,
	},
}
-- lazy main entry
require("lazy").setup(default_plugins, require("plugins.lazy_nvim"))
