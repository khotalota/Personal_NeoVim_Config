local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Optimize LSP settings
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- LSP Performance settings
local on_attach = function(client, bufnr)
    -- Disable LSP highlighting (use Treesitter instead)
    client.server_capabilities.semanticTokensProvider = nil

    -- Optimize document highlights
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        -- Web Development
        "html",
        "cssls",
        "ts_ls",
        "emmet_ls",
        "intelephense",           -- PHP
        -- Systems Programming
        "clangd",                 -- C/C++
        "rust_analyzer",          -- Rust
        "zls",                    -- Zig
        "gopls",                  -- Go
        -- Scripting Languages
        "pyright",                -- Python
        "lua_ls",                 -- Lua
        "julials",                -- Julia
        "elixirls",               -- Elixir
        "bashls",                 -- Bash
        "kotlin_language_server", -- Kotlin
        -- Java
        "jdtls",                  -- Java
    },
})

local mason = require('mason')
mason.setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
        }
    }
})

-- Setup language servers
local servers = {
    -- Web Development
    "html",
    "cssls",
    "ts_ls",
    "emmet_ls",
    -- Systems Programming
    "clangd",
    "rust_analyzer",
    "zls",
    "gopls",
    -- Scripting Languages
    "pyright",
    "lua_ls",
    "julials",
    "elixirls",
    "bashls",
    "kotlin_language_server",
    -- Java
    "jdtls",
}

-- Setup basic servers
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,    -- Debounce didChange notifications
        },
        settings = {
            -- Language specific optimizations
            ["lua_ls"] = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
            ["pyright"] = {
                analysis = {
                    typeCheckingMode = "off",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = "workspace",
                },
            },
            ["rust_analyzer"] = {
                checkOnSave = {
                    command = "clippy",
                    extraArgs = {"--", "-W", "clippy::pedantic"},
                },
            },
        },
    })
end

-- Special configurations for specific servers
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }, -- Recognize vim global
            },
        },
    },
})

-- PHP LSP configuration
lspconfig.intelephense.setup({
    capabilities = capabilities,
    init_options = {
        storagePath = vim.fn.stdpath('data') .. '/intelephense',
        globalStoragePath = vim.fn.expand('$HOME') .. '/.intelephense',
    },
    settings = {
        intelephense = {
            files = {
                maxSize = 1000000,
            },
            stubs = {
                'apache', 'bcmath', 'bz2', 'calendar', 'composer', 'curl', 'date',
                'dom', 'fileinfo', 'filter', 'ftp', 'gd', 'gettext', 'hash', 'iconv',
                'imap', 'intl', 'json', 'ldap', 'libxml', 'mbstring', 'mysqli',
                'mysqlnd', 'openssl', 'pcntl', 'pcre', 'PDO', 'pdo_mysql', 'Phar',
                'readline', 'session', 'sockets', 'sodium', 'standard', 'tokenizer',
                'xml', 'xmlreader', 'xmlwriter', 'zip', 'zlib'
            },
        },
    },
    filetypes = { "php" }, -- Explicitly set filetypes
    root_dir = function(pattern)
        local util = require('lspconfig.util')
        return util.root_pattern('composer.json', '.git', 'index.php')(pattern)
    end,
})

lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
})

-- Java LSP configuration
lspconfig.jdtls.setup({
    capabilities = capabilities,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.Assume.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.junit.jupiter.api.Assumptions.*",
                    "org.junit.jupiter.api.DynamicContainer.*",
                    "org.junit.jupiter.api.DynamicTest.*",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                useBlocks = true,
            },
        },
    },
})

-- Global mappings
vim.keymap.set('n', 'de', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
