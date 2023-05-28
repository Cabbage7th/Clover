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

    "json",
    "yaml",
    "markdown",
    "markdown_inline",

    "cmake",
    "gitcommit",
  },
    rainbow = {
        enable = true,
        -- list of languages you want to disable the plugin for
        disable = { 'jsx' },
        -- Which query to use for finding delimiters
        query = 'rainbow-parens',
        -- Highlight the entire buffer all at once
        strategy = require('ts-rainbow').strategy.global,
    },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
