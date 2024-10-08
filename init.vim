lua require('standard_config')

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive', { 'on': 'G'}       " Git integration into vim 
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterToggle'}   " Shows git diffs in the sign columns

Plug 'mfussenegger/nvim-jdtls'

Plug 'nvim-lua/plenary.nvim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'andymass/vim-matchup'
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'
Plug 'ggandor/leap.nvim'

Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'sbdchd/neoformat'

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'tpope/vim-surround'
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'
Plug 'lervag/vimtex'
call plug#end()

"=======================Lualine_config==================="
lua << EOF
-- Existing Lua configuration
-- require('lualine_config')
local lualine_config_path = vim.fn.stdpath('config') .. '/lua/lualine_config.lua'
if vim.fn.filereadable(lualine_config_path) == 1 then
    dofile(lualine_config_path)
else
    print("Warning: rust_lsp_config.lua not found at " .. lualine_config_path)
end
EOF

"=======================Rust_LSP==========================="
lua << EOF
local rust_lsp_config_path = vim.fn.stdpath('config') .. '/lua/rust_lsp_config.lua'
if vim.fn.filereadable(rust_lsp_config_path) == 1 then
    dofile(rust_lsp_config_path)
else
    print("Warning: rust_lsp_config.lua not found at " .. rust_lsp_config_path)
end
EOF

"======================Telescope_config===================="
lua << EOF
local telescope_config_path = vim.fn.stdpath('config') .. '/lua/telescope_config.lua'
if vim.fn.filereadable(telescope_config_path) == 1 then
    dofile(telescope_config_path)
else
    print("Warning: telescope_config.lua not found at " .. telescope_config_path)
end

local fzf_config_path = vim.fn.stdpath('config') .. '/lua/fzf_config.lua'
if vim.fn.filereadable(fzf_config_path) == 1 then
    dofile(fzf_config_path)
else
    print("Warning: fzf_config.lua not found at " .. fzf_config_path)
end
EOF

"=======================Toggleterm=========================="
lua << EOF
local toggleterm_config_path = vim.fn.stdpath('config') .. '/lua/toggleterm_config.lua'
if vim.fn.filereadable(toggleterm_config_path) == 1 then
    dofile(toggleterm_config_path)
else
    print("Warning: toggleterm_config.lua not found at " .. toggleterm_config_path)
end
EOF

"=======================LSP-Status=========================="
lua << EOF
local lsp_status_config_path = vim.fn.stdpath('config') .. '/lua/lsp_status_config.lua'
if vim.fn.filereadable(lsp_status_config_path) == 1 then
    dofile(lsp_status_config_path)
else
    print("Warning: lsp_status_config.lua not found at " .. lsp_status_config_path)
end
EOF

"======================Leap-navigation========================="
lua << EOF
local leap_navigation_config_path = vim.fn.stdpath('config') .. '/lua/leap_navigation_config.lua'
if vim.fn.filereadable(leap_navigation_config_path) == 1 then
    dofile(leap_navigation_config_path)
else
    print("Warning: leap_navigation_config.lua not found at " .. leap_navigation_config_path)
end
EOF

"=======================Nvim-tree==========================="
lua << EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- Keymaps for nvim-tree
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
EOF

"=======================Home_find==========================="
lua << EOF
function _G.telescope_find_files_in_home()
  local home = os.getenv("HOME")
  require('telescope.builtin').find_files({
    prompt_title = "Find Files in Home",
    cwd = home,
    hidden = true,
    file_ignore_patterns = {
      "%.cache/.*",
      "%.local/.*",
      "%.npm/.*",
      "%.config/.*",
      "node_modules/.*",
      ".git/.*",
    }
  })
end
EOF
"============================================================"

command! FindInHome lua telescope_find_files_in_home()

set background=dark
colorscheme slate

let mapleader = " "

let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_complete_enabled = 1
let g:vimtex_echo_target_width = 80
let g:vimtex_compiler_latexmk = {'options': '-pdf', 'build_dir': 'build'}

" nnoremap <leader>cv :VimtexCompile\|VimtexView<CR>

nnoremap <leader>fh :FindInHome<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
xnoremap <A-j> :m '>+1<CR>gv=gv
xnoremap <A-k> :m '<-2<CR>gv=gv

function! ToggleComment()
  if getline('.') =~ '^\s*\/\/'  " For C, C++, Java, Go, Rust
    s/^\s*\/\// /
  elseif getline('.') =~ '^\s*#'  " For Python, Julia
    s/^\s*#// 
  else
    if &filetype == 'c' || &filetype == 'cpp' || &filetype == 'java' || &filetype == 'go' || &filetype == 'rust'
      s/^/\/\/ /
    elseif &filetype == 'python' || &filetype == 'julia'
      s/^/# /
    endif
  endif
endfunction

nnoremap <C-/> :call ToggleComment()<CR>

vnoremap <C-/> :call ToggleComment()<CR>



lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c", "cpp", "python", "java", "rust", "julia", "lua", "vim",
    "javascript", "typescript", "html", "css"
  },
  highlight = {
    enable = true,
  },
}

require('lualine').setup()
require('bufferline').setup()
require('nvim-autopairs').setup()
require('Comment').setup()

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
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
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    'clangd',
    'jdtls',
    'pyright',
    'julials',
    'rust_analyzer',
    'ts_ls',
    'html',
    'cssls',
    }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
EOF


autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require('java_lsp_config')
augroup END
