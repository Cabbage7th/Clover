local M = {}
-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
    require("mappings").lspconfig(bufnr)

    -- dim code not used
    if not vim.g.lsp_semantic_tokens then
        client.server_capabilities.semanticTokensProvider = nil
    end
    local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = "󰋼 " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    -- attach nvim-navic
    local navic = require("nvim-navic")
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

require("lspconfig").lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}
require("lspconfig").clangd.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
}
require("lspconfig").bashls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    single_file_support = true,
	filetypes = { "sh", "zsh" },
}
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "jedi_language_server", "cmake", "marksman", "jsonls", "bashls" }

local lspconfig = require "lspconfig"
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    single_file_support = true,
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
end

return M
