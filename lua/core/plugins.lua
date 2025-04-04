-- lua/core/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("config.colorscheme")
        end,
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.nvim-tree")
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("config.lsp")
        end,
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("config.cmp")
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require("config.treesitter")
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true }
        },
        config = function()
            require("config.telescope")
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "BufReadPre",
        config = function()
            require("config.gitsigns")
        end,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        lazy = true,
        event = "VimEnter",
        --dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config.lualine")
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("config.autopairs")
        end,
    },

    -- Comments
    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "windwp/nvim-ts-autotag", -- Auto close and rename HTML tags
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua", -- Color highlighting for CSS
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("colorizer").setup()
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        lazy = true,
        keys = { "<C-\\>" }, -- Load when mapping is used
        config = function()
            require("toggleterm").setup({
                size = 20,
                open_mapping = [[<c-\>]],
                direction = "float",
                close_on_exit = true,
            })
        end
    },

    -- Debugging
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        cmd = { "DapToggleBreakpoint", "DapContinue" },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
        },
    },

    -- Session Management
    {
        "rmagatti/auto-session",
        lazy = false,
        event = "VimEnter",
        config = function()
            require("auto-session").setup({
                lazy_support = true,
            })
        end,
    },

    -- Note Taking
    { 'nvim-neorg/neorg',        lazy = true, ft = 'norg' },

    -- Database Access
    { 'tpope/vim-dadbod',        lazy = true, ft = { "sql", "mysql" } },

    -- Markdown Preview
    { 'ellisonleao/glow.nvim',   lazy = true, cmd = "Glow" },

    -- Task Runner
    { 'GustavoKatel/tasks.nvim', lazy = true, ft = "todo" },

    -- Browser Integration
    { 'glacambre/firenvim',      lazy = true, event = "VeryLazy" },
})
