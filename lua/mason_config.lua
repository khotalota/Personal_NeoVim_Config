-- Mason setup
require("mason").setup()

-- Mason LSP setup
require("mason-lspconfig").setup({
	ensure_installed = { "rust_analyzer", "lua_ls", "pyright" },
	automatic_installation = true,
})

-- Mason Null-ls setup (optional)
require("mason-null-ls").setup({
	ensure_installed = { "prettier", "eslint_d", "stylua" },
	automatic_installation = true,
})

-- Mason DAP setup (ensure nvim-dap is installed)
require("mason-nvim-dap").setup({
	ensure_installed = { "cppdbg", "python" },
	automatic_installation = true,
})
