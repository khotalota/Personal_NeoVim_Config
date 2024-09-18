-- Disable search highlighting
vim.cmd('set nohlsearch')

-- Show line numbers
vim.cmd('set number')

-- Use relative line numbers in insert mode
vim.cmd('autocmd InsertEnter * set norelativenumber')
vim.cmd('autocmd InsertLeave * set relativenumber')

-- Use relative line numbers
vim.cmd('set relativenumber')

-- Indentation settings
vim.cmd('set autoindent')
vim.cmd('set expandtab')
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=4')
vim.cmd('set smarttab')
vim.cmd('set softtabstop=4')

-- Enable mouse support
vim.cmd('set mouse=a')

-- Clipboard settings
vim.cmd('set clipboard+=unnamedplus')

-- Backup settings
vim.cmd('set hidden')
vim.cmd('set nobackup')
vim.cmd('set nowritebackup')

-- Command-line height
vim.cmd('set cmdheight=2')

-- Update time
vim.cmd('set updatetime=300')

-- Short message settings
vim.cmd('set shortmess+=c')

-- Sign column
vim.cmd('set signcolumn=yes')

-- True color support
vim.cmd('set termguicolors')

