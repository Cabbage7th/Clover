local ensure_installed = {
    -- lua stuff
    --"lua-language-server",
    "lua_ls",

    -- web dev stuff
    "cssls",
    "html",
    "tsserver",

    -- shell
    "bashls",
    -- c/cpp stuff
    "clangd",

    -- python
    "jedi_language_server",

    "cmake",
    "marksman",
    "jsonls",
}

local null_ls_install_list = {
    "stylua",
    --"deno",
    "prettier",
    "shellcheck",
    "clang-format",
    "asm-lsp",
}

require("mason").setup({

    ensure_installed = null_ls_install_list,
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
})
require("mason-lspconfig").setup {
    ensure_installed = ensure_installed,
}
-- custom nvchad cmd to install all mason binaries listed
vim.api.nvim_create_user_command("MasonInstallAll", function()
    vim.cmd("MasonInstall " .. table.concat(null_ls_install_list, " "))
end, {})
