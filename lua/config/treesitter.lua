-- lua/config/treesitter.lua
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    -- Web Development
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",

    -- Systems Programming
    "c",
    "cpp",
    "rust",
    "zig",
    "go",

    -- Scripting Languages
    "python",
    "lua",
    "julia",
    "elixir",
    "bash",
    "kotlin",

    -- Additional useful parsers
    "json",
    "yaml",
    "toml",
    "regex",
    "markdown",
    "vim",
    "dockerfile",
    "gitignore",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },

})

-- Set up autotag separately
require('nvim-ts-autotag').setup()
