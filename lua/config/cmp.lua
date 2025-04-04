-- lua/config/cmp.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Cache completion results
vim.g.completion_enable_snippet = 'luasnip'
vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }

cmp.setup({
    performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 100,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip',  priority = 750 },
        { name = 'buffer',   priority = 500, keyword_length = 5 },
        { name = 'path',     priority = 250 },
    }),
    preselect = cmp.PreselectMode.None,
})

-- Add performance monitoring
vim.api.nvim_create_user_command('CheckStartupTime', function()
    local startup_time = vim.fn.startuptime()
    vim.api.nvim_echo({{string.format("Startup Time: %sms", startup_time), 'Normal'}}, true, {})
end, {})

-- Optimize file watchers
vim.fn.system('echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p')
