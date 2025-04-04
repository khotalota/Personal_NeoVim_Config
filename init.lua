vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- init.lua
require('core.options')
require('core.keymaps')
require('core.plugins')
-- require('core.colorscheme')
require('core.autocmds')

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
