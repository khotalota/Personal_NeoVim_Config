local lsp_status = require('lsp-status')
lsp_status.register_progress()

local on_attach = function(client, bufnr)
    lsp_status.on_attach(client)
end

local capabilities = vim.tbl_extend('keep',
    require('cmp_nvim_lsp').default_capabilities(),
    lsp_status.capabilities
)
