local M = {}

M.options = {
    nvchad_branch = "v2.0",
}

M.ui = {
    ------------------------------- theme -------------------------------------
    theme = {
        theme_toggle = { "onedark", "one_light" },
        name = "onedark", -- onedark/tokyonight/catppuccin/kanagawa/tender
        style = "dark",
        transparency = false,
        lsp_semantic_tokens = false, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
    },

    -- cmp themeing
    cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored", -- colored / simple
    },

    telescope = { style = "borderless" }, -- borderless / bordered

    lsp = {
        -- show function signatures i.e args as you type
        signature = {
            disabled = false,
            silent = true, -- silences 'no signature help available' message from appearing
        },
    },
}

--M.plugins = "" -- path i.e "custom.plugins", so make custom/plugins.lua file

--M.lazy_nvim = require "plugins.configs.lazy_nvim" -- config for lazy.nvim startup options

--M.mappings = {}

return M
