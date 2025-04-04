-- lua/core/keymaps.lua
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
--vim.g.mapleader = " "

keymap("n", "<Esc>", ":noh<CR>", { silent = true })
keymap("n", "<leader>r", ":source $MYVIMRC<CR>", { silent = true })
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- File explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })

-- LSP
keymap('n', '<leader>lf', vim.lsp.buf.format, { desc = '[L]SP [F]ormat' })
keymap('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = '[L]SP [I]nfo' })

-- Debugging
--keymap('n', '<F5>', require('dap').continue, { desc = 'Debug: Start/Continue' })
--keymap('n', '<F10>', require('dap').step_over, { desc = 'Debug: Step Over' })
--keymap('n', '<F11>', require('dap').step_into, { desc = 'Debug: Step Into' })
--keymap('n', '<F12>', require('dap').step_out, { desc = 'Debug: Step Out' })
--keymap('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
