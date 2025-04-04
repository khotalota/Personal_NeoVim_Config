-- lua/core/options.lua
local opt = vim.opt
local cache_dir = vim.fn.stdpath('cache')

-- General
opt.mouse = 'a'                      -- Enable mouse support
opt.clipboard = 'unnamedplus'        -- Use system clipboard
opt.swapfile = false                 -- Don't use swapfile
opt.completeopt = 'menuone,noselect' -- Better completion experience
opt.conceallevel = 0                 -- Make `` visible in markdown files
opt.fileencoding = "utf-8"           -- File encoding
opt.hidden = true                    -- Enable background buffers
opt.ttyfast = true
opt.hlsearch = true                  -- Highlight found searches
opt.ignorecase = true                -- Ignore case in search patterns
opt.smartcase = true                 -- Override ignorecase if search contains capitals
opt.smartindent = true               -- Insert indents automatically
opt.splitbelow = true                -- Put new windows below current
opt.splitright = true                -- Put new windows right of current
opt.termguicolors = true             -- True color support
opt.timeoutlen = 250                 -- Time to wait for a mapped sequence to complete
opt.undofile = true                  -- Enable persistent undo
opt.updatetime = 250                 -- Faster completion
opt.redrawtime = 1500                -- Allow more time for loading syntax
opt.lazyredraw = true                -- Don't redraw screen during macros
opt.shadafile = "NONE"               -- Don't read or write ShaDa file on startup
opt.shada = "!,'100,<50,s10,h"       -- Optimize shada file settings

-- UI
--opt.number = true -- Show line numbers
opt.showtabline = 1                   -- Show tabline only if tabs exist

--opt.relativenumber = false             -- Relative line numbers
opt.cursorline = true -- Enable highlighting of the current line
opt.signcolumn = "no"  -- Always show the signcolumn
opt.wrap = false       -- Display long lines as just one line
opt.scrolloff = 8      -- Lines of context
opt.sidescrolloff = 8  -- Columns of context

-- Tabs
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4   -- Size of an indent
opt.tabstop = 4      -- Number of spaces tabs count for
opt.softtabstop = 4  -- Number of spaces that a <Tab> counts for

-- Toggle relative and absolute numbers based on mode
local group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
        vim.opt.number = true
    end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = group,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
    end,
})

-- Memory management
vim.g.loaded_perl_provider = 0        -- Disable perl provider
vim.g.loaded_ruby_provider = 0        -- Disable ruby provider
vim.g.loaded_node_provider = 0        -- Disable node provider
vim.g.loaded_python_provider = 0      -- Disable python2 provider
vim.g.python3_host_prog = vim.fn.exepath('python3') -- Set python3 path explicitly
