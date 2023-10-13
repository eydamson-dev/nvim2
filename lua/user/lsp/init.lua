require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 'bashls', 'cssmodules_ls', 'eslint', 'html', 'jsonls', 'tsserver', 'lua_ls', }
})

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...

require("user.lsp.lsp-installer")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")

