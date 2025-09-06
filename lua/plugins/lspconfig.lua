local M = {}
-- export on_attach & capabilities for custom lspconfigs

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		if client then
			-- remap keys
			require("mappings").lspconfig(bufnr)
			-- dim code not used
			if not vim.g.lsp_semantic_tokens then
				client.server_capabilities.semanticTokensProvider = false
			end
			-- attach nvim-navic
			local navic = require("nvim-navic")
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
			-- custome diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = "󰋼 " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end
	end,
})

-- if you just want default config for the servers then put them in a table
local servers = { "lua_ls", "bashls", "html", "cssls", "ts_ls", "jedi_language_server", "cmake", "marksman", "jsonls", "bashls", "clangd" }

vim.lsp.enable(
	servers,
	{
		--capabilities = { },
	}
)

return M
