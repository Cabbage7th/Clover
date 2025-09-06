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
			vim.diagnostic.config({
			  -- icons
			  signs = {
				text = {
				  [vim.diagnostic.severity.ERROR] = " ",
				  [vim.diagnostic.severity.WARN]  = "⚠ ",
				  [vim.diagnostic.severity.INFO]  = "󰌵 ",
				  [vim.diagnostic.severity.HINT]  = "󰋼 ",
				},
				linehl = {
				  --[vim.diagnostic.severity.ERROR] = "ErrorMsg",
				  --[vim.diagnostic.severity.WARN]  = "WarningMsg",
				  --[vim.diagnostic.severity.INFO]  = "InfoMsg",
				  --[vim.diagnostic.severity.HINT]  = "HintMsg",
				},
				numhl = {
				  [vim.diagnostic.severity.ERROR] = "ErrorMsg",
				  [vim.diagnostic.severity.WARN]  = "WarningMsg",
				  [vim.diagnostic.severity.INFO]  = "InfoMsg",
				  [vim.diagnostic.severity.HINT]  = "HintMsg",
				}
			  },

			  virtual_text = {
				prefix = "●",
				spacing = 2,
			  },
			  float = { border = "rounded" },
			})
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
