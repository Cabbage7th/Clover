local null_ls = require("null-ls")

null_ls.setup({
    debug = true,
    sources = {
        -- webdev stuff
        null_ls.builtins.formatting.deno_fmt,                                               -- choosed deno for ts/js files cuz its very fast!
        null_ls.builtins.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }), -- so prettier works only on these filetypes

        -- Lua
        null_ls.builtins.formatting.stylua,

        -- cpp
        null_ls.builtins.formatting.clang_format,
        --null_ls.builtins.completion.spell,
    },
})
