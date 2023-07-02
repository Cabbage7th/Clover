-- n, v, i, t = mode names

local M = {}

M.general_mapping = function ()

    vim.keymap.set('i', "jk", "<ESC>")
    -- go to  beginning and end
    vim.keymap.set('i', "<C-b>", "<ESC>^i")
    vim.keymap.set('i', "<C-e>", "<End>")

    -- navigate within insert mode
    vim.keymap.set('i', "<C-h>", "<Left>")
    vim.keymap.set('i', "<C-l>", "<Right>")
    vim.keymap.set('i', "<C-j>", "<Down>")
    vim.keymap.set('i', "<C-k>", "<Up>")

    vim.keymap.set('n', "<Esc>", ":noh <CR>")

    -- switch between windows
    vim.keymap.set('n', "<C-h>", "<C-w>h")
    vim.keymap.set('n', "<C-l>", "<C-w>l")
    vim.keymap.set('n', "<C-j>", "<C-w>j")
    vim.keymap.set('n', "<C-k>", "<C-w>k")
    -- switch buffers
    vim.keymap.set('n', "<S-j>", "<cmd> bprevious <CR>")
    vim.keymap.set('n', "<S-k>", "<cmd> bnext <CR>")
    -- switch tabs

    -- save
    vim.keymap.set('n', "<C-s>", "<cmd> w <CR>")
    vim.keymap.set('n', "ss", "<cmd> w <CR>")
    vim.keymap.set('n', "sa", "<cmd> wa <CR>")
    -- Copy whole file
    vim.keymap.set('n', "<C-c>", "<cmd> %y+ <CR>")
    -- toggle line numbers
    vim.keymap.set('n', "<leader>n", "<cmd> set nu! <CR>")
    -- toggle relative line numbers
    vim.keymap.set('n', "<leader>rn", "<cmd> set rnu! <CR>")

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    vim.keymap.set({'n', 'x'}, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
    vim.keymap.set({'n', 'x'}, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})
    vim.keymap.set({'n', 'v'}, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})
    vim.keymap.set({'n', 'v'}, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})

    -- new buffer
    vim.keymap.set('n', "<leader>n", "<cmd> enew <CR>")

    vim.keymap.set('t', "<C-x>",vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true))

    -- Don't copy the replaced text after pasting in visual mode
    vim.keymap.set('x', "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true })

    vim.keymap.set('v', "<", "<gv")
    vim.keymap.set('v', ">", ">gv")
end

M.lspconfig = function (bufnr)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end
    map(
        {'n'},
        "gD",
        function()
            vim.lsp.buf.declaration()
        end
    )
    map(
        {'n'},
        "gd",
        function()
            vim.lsp.buf.definition()
        end
    )
    map(
        {'n'},
        "<leader>H",
        function()
            vim.lsp.buf.hover()
        end
    )
    map(
        {'n'},
        "gi",
        function()
            vim.lsp.buf.implementation()
        end
    )
    --map(
        --{'n'},
        --"gr",
        --function()
            --vim.lsp.buf.references()
        --end
    --)
    map(
        {'n'},
        "<leader>ls",
        function()
            vim.lsp.buf.signature_help()
        end
    )
    map(
        {'n'},
        "<leader>D",
        function()
            vim.lsp.buf.type_definition()
        end
    )
    map(
        {'n'},
        "<leader>A",
        function()
            vim.lsp.buf.code_action()
        end
    )
    --map(
        --{'n'},
        --"<leader>df",
        --function()
            --vim.diagnostic.open_float { border = "rounded" }
        --end
    --)
    map(
        {'n'},
        "[e",
        function()
            vim.diagnostic.goto_prev()
        end
    )
    map(
        {'n'},
        "]e",
        function()
            vim.diagnostic.goto_next()
        end
    )
    map(
        {'n'},
        "<leader>dl",
        function()
            vim.diagnostic.setloclist()
        end
    )
    map(
        {'n'},
        "<leader>wl",
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
    )
    map(
        {'n'},
        "<leader>wr",
        function()
            vim.lsp.buf.remove_workspace_folder()
        end
    )
    map(
        {'n'},
        "<leader>wa",
        function()
            vim.lsp.buf.add_workspace_folder()
        end
    )
    map(
        {'n'},
        "<leader>rn",
        function()
            vim.lsp.buf.rename()
        end
    )
    map(
        {'n'},
        "<leader>fm",
        function()
            vim.lsp.buf.format { async = true }
        end
    )
    map(
        {'v'},
        "<leader>fm",
        function()
            vim.lsp.buf.format {
                async = true,
                range = {
                    ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                    ["end"] = vim.api.nvim_buf_get_mark(0, ">")
                },
            }
        end
    )
end

M.nvimtree = function ()
    vim.keymap.set({'n'}, "<C-e>", "<cmd> NvimTreeToggle <CR>")
end

M.telescope = function ()
    -- find
    vim.keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>")
    vim.keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>")
    vim.keymap.set("n", "<leader>fr", "<cmd> Telescope live_grep <CR>")
    vim.keymap.set("n", "<leader>fw", "<cmd> Telescope grep_string <CR>")
    vim.keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
    vim.keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>")
    vim.keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
    vim.keymap.set("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>")

    -- lsp
    vim.keymap.set("n", "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>")
    vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <CR>")
    vim.keymap.set("n", "<leader>fd", "<cmd> Telescope diagnostics <CR>")
    vim.keymap.set("n", "<leader>gi", "<cmd> Telescope lsp_incoming_calls <CR>")
    vim.keymap.set("n", "<leader>go", "<cmd> Telescope lsp_outgoing_calls <CR>")

    -- git
    vim.keymap.set("n", "<leader>cm", "<cmd> Telescope git_commits <CR>")
    vim.keymap.set("n", "<leader>gt", "<cmd> Telescope git_status <CR>")

end

M.nvterm = function()
    vim.keymap.set( {'t', 'n'}, "<A-i>",
        function()
            require("nvterm.terminal").toggle "float"
        end
    )
    vim.keymap.set( {'t', 'n'}, "<A-h>",
        function()
            require("nvterm.terminal").toggle "horizontal"
        end
    )
    vim.keymap.set( {'t', 'n'}, "<A-v>",
        function()
            require("nvterm.terminal").toggle "vertical"
        end
    )
end

M.whichkey = function ()
    vim.keymap.set(
        {'n'},
        "<leader>wk",
        function()
            local input = vim.fn.input "WhichKey: "
            vim.cmd("WhichKey " .. input)
        end
    )
    vim.keymap.set(
        {'n'},
        "<leader>wK",
        function()
            vim.cmd "WhichKey"
        end
    )
end

-- TODO : key conflict
M.blankline = function ()
     vim.keymap.set(
         {'n'},
         "<leader>[[",
         function()
             local ok, start = require("indent_blankline.utils").get_current_context(
                 vim.g.indent_blankline_context_patterns,
                 vim.g.indent_blankline_use_treesitter_scope
                 )
             if ok then
                 vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
                 vim.cmd [[normal! _]]
             end
         end
     )
end

M.gitsigns = function (bufnr)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end
    -- Navigation through hunks
    map(
        {'n'},
        "[c",
        function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                require("gitsigns").prev_hunk()
            end)
            return "<Ignore>"
        end,
        { expr = true }
    )
    map(
        {'n'},
        "]c",
        function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                require("gitsigns").next_hunk()
            end)
            return "<Ignore>"
        end,
        { expr = true }
    )
    -- Actions
    map(
        {'n'},
        "<leader>ph",
        function()
            require("gitsigns").preview_hunk()
        end
    )
    map(
        {'n'},
        "<leader>rh",
        function()
            require("gitsigns").reset_hunk()
        end
    )
    map(
        {'n'},
        "<leader>gb",
        function()
            package.loaded.gitsigns.blame_line()
        end
    )
    map(
        {'n'},
        "<leader>td",
        function()
            require("gitsigns").toggle_deleted()
        end
    )
end
M.hop = function ()
    local hop = require('hop')

    --local directions = require('hop.hint').HintDirection

    vim.keymap.set('n', '<leader><leader>w',
        function()
            hop.hint_words()
        end,
        {remap=true}
    )

    vim.keymap.set('n', '<leader><leader>p',
        function()
            hop.hint_patterns()
        end,
        {remap=true}
    )
end

M.bufferline = function ()
    vim.keymap.set('n', '<leader>bp', "<cmd> BufferLinePick <CR>", {silent = true})
    vim.keymap.set('n', '<leader>bc', "<cmd> BufferLinePickClose <CR>", {silent = true})
end

M.cscope = function ()
    vim.cmd('nmap <C-\\>s :Cscope find s <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>g :Cscope find g <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>c :Cscope find c <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>t :Cscope find t <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>e :Cscope find e <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>f :Cscope find f <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>i :Cscope find i <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>d :Cscope find d <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>a :Cscope find a <C-R>=expand("<cword>")<CR><CR>')
    vim.cmd('nmap <C-\\>b :Cscope build <CR><CR>')
end

return M
