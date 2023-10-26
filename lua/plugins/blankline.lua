require("ibl").setup( {
    --indentLine_enabled = 1,
    exclude = {
        filetypes = {
            "help",
            "terminal",
            "lazy",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "nvdash",
            "nvcheatsheet",
            "",
        },
        buftypes = {
            "terminal",
        }
    },
    scope = {
        show_start = true,
        show_end = true,
        show_exact_scope = true,
    },

    --buftype_exclude = { "terminal" },
    --show_trailing_blankline_indent = true,
    --show_first_indent_level = false,
    --show_current_context = true,
    --show_current_context_start = true,
    --show_end_of_line = true,
    --space_char_blank_line = "·",
}
)
