return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
        "mfussenegger/nvim-dap",
    },

    config = function()
        local dap = require("dap")
        local widgets = require('dap.ui.widgets')

        require("mason-nvim-dap").setup {
            automatic_setup = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
                php = function(config)
                    config.configurations = {
                        {
                            type = 'php',
                            request = 'launch',
                            name = 'Listen for Xdebug',
                            port = 9003,
                            log = true,
                            pathMappings = {
                                ['/var/www/html/'] = vim.fn.getcwd() .. '/',
                            },
                            hostname = '0.0.0.0',
                        }
                    }
                    require('mason-nvim-dap').default_setup(config)
                end,
            },
        }

        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })

        -- keybindings
        vim.keymap.set('n', '<leader>xc', function() dap.continue() end)
        vim.keymap.set('n', '<leader>xs', function() dap.step_over() end)
        vim.keymap.set('n', '<leader>xi', function() dap.step_into() end)
        vim.keymap.set('n', '<leader>xo', function() dap.step_out() end)
        vim.keymap.set('n', '<leader>xa', function() dap.toggle_breakpoint() end)
        vim.keymap.set('n', '<leader>xA', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
            opts)
        vim.keymap.set('n', '<leader>xb', function() dap.set_breakpoint() end)
        vim.keymap.set('n', '<leader>xm',
            function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
        vim.keymap.set('n', '<Leader>xr', function() dap.repl.open() end)
        vim.keymap.set('n', '<Leader>xl', function() dap.run_last() end)

        vim.keymap.set({ 'n', 'v' }, '<Leader>xh', function()
            widgets.hover()
        end)
        vim.keymap.set({ 'n', 'v' }, '<Leader>xp', function()
            widgets.preview()
        end)
        vim.keymap.set('n', '<Leader>xwf', function()
            widgets.centered_float(widgets.frames)
        end)
        vim.keymap.set('n', '<Leader>xws', function()
            widgets.centered_float(widgets.scopes)
        end)
    end,

    ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'php',
        'delve',
    },
}
