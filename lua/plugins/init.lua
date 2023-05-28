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
            require("lazy").load { plugins = "nvim-colorizer.lua" }
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
        opts = function()
            return { override = require("icons").devicons }
        end,
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        init = function()
            require("lazy").load { plugins = "indent-blankline.nvim" }
        end,
        opts = function()
            return require("plugins.configs.blankline").blankline
        end,
        config = function(_, opts)
            require("mappings").blankline()
            require("indent_blankline").setup(opts)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        init = function()
            require("lazy").load { plugins = "nvim-treesitter" }
        end,
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            return require "plugins.configs.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
        dependencies = {
            {
                "HiPhish/nvim-ts-rainbow2",
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
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
            return require("plugins.configs.gitsigns").gitsigns
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },

    -- lsp stuff
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
        opts = function()
            return require "plugins.configs.mason"
        end,
        config = function(_, opts)
            require("mason").setup(opts)

            -- custom nvchad cmd to install all mason binaries listed
            vim.api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end, {})

            vim.g.mason_binaries_list = opts.ensure_installed
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "plugins.configs.null-ls"
                end,
            },
            {
                "ray-x/lsp_signature.nvim",
                opts = function()
                    return require "plugins.configs.lsp_signature"
                end,
                config = function(_, opts)
                    require "lsp_signature".setup(opts)
                end,
            },
        },
        init = function()
            require("lazy").load { plugins = "nvim-lspconfig" }
        end,
        config = function()
            require "plugins.configs.lspconfig"
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
                    require("plugins.configs.luasnip").luasnip(opts)
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
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
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
            },
        },

        opts = function()
            return require "plugins.configs.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    -- file managing , picker etc
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        lazy = false,
        init = function()
            require("lazy").load { plugins = "nvim-tree.lua" }
            require("mappings").nvimtree()
        end,
        opts = function()
            return require "plugins.configs.nvimtree"
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
            vim.g.nvimtree_side = opts.view.side
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        cmd = "Telescope",

        init = function()
            require("mappings").telescope()
        end,

        opts = function()
            return require "plugins.configs.telescope"
        end,

        config = function(_, opts)
            local telescope = require "telescope"
            telescope.setup(opts)
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
            return require "plugins.configs.whichkey"
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
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        init = function()
            require("lazy").load { plugins = "hop.nvim" }
        end,
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            require("mappings").hop()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            {
                'nvim-tree/nvim-web-devicons'
            }
        },
        init = function()
            require("lazy").load { plugins = "lualine.nvim" }
        end,
        opts = function()
            return require "plugins.configs.lualine"
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {'nvim-tree/nvim-web-devicons'},
        init = function()
            require("lazy").load { plugins = "bufferline.nvim" }
        end,
        opts = function()
            return require "plugins.configs.bufferline"
        end,
        config = function(_, opts)
            require("bufferline").setup(opts)
            require("mappings").bufferline()
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        lazy = false,
        config = function()
            require("git-conflict").setup()
        end,
    },
    {
        'dhananjaylatkar/cscope_maps.nvim', -- cscope keymaps
        lazy = false,
        config = function()
            require('cscope_maps').setup({
                disable_maps = true, -- true disables my keymaps, only :Cscope will be loaded
                cscope = {
                    db_file = "./cscope.out", -- location of cscope db file
                    exec = "cscope", -- "cscope" or "gtags-cscope"
                    use_telescope = true, -- true will show results in telescope picker
                    db_build_cmd_args = { "-bqkv" }, -- args used for db build (:Cscope build)
                },
            })
            require("mappings").cscope()
        end,
    },


    
    -- vimscript plugins
    {
        'scrooloose/nerdcommenter',
        lazy = false,
    },

    {
        'wellle/targets.vim',
        lazy = false,
    },
    {
        'tpope/vim-surround',
        lazy = false,
    },
    {
        'nathangrigg/vim-beancount',
        lazy = false,
    },
}
-- lazy main entry
require("lazy").setup(default_plugins, require("plugins.configs.lazy_nvim"))
