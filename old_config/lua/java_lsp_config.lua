local config = {
    cmd = {'/run/current-system/sw/bin/jdtls'},
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = function()
        return vim.fn.getcwd()
    end,

    settings = {
        java = {

        }
    },
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)
