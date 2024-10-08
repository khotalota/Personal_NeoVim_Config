local nvim_lsp = require('lspconfig')

local rust_analyzer_cmd = vim.fn.trim(vim.fn.system('rustup which rust-analyzer'))

nvim_lsp.rust_analyzer.setup {
    cmd = { rust_analyzer_cmd },
    on_attach = function(client, bufnr)
        -- Existing on_attach function from your init.vim
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }

        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    end,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy"
            },
        }
    },
    flags = {
        debounce_text_changes = 150,
    },
}

-- You can add any additional Rust-specific configurations here
