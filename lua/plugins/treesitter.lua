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
    "beancount"
  },
    rainbow = {
        enable = true,
        -- list of languages you want to disable the plugin for
        disable = function (_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
            return file_size > 1024 * 1024
        end,
        -- Which query to use for finding delimiters
        query = 'rainbow-parens',
        -- Highlight the entire buffer all at once
        strategy = require('ts-rainbow').strategy.global,
    },

  highlight = {
    enable = true,
    use_languagetree = true,
    disable = function (_, bufnr)
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
        return file_size > 1024 * 1024
    end
  },

  indent = {
        enable = true,
        disable = function (_, bufnr)
            local buf_name = vim.api.nvim_buf_get_name(bufnr)
            local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
            return file_size > 1024 * 1024
        end
    },
}

return options
