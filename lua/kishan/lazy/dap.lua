return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },

        config = function()
            local dap = require "dap"
            local ui = require "dapui"

            require("dapui").setup()
            require("dap-go").setup()


            --PHP xdebug setup
            local dap = require("dap")

            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = { os.getenv("HOME") .. "/apps/vscode-php-debug/out/phpDebug.js" }
            }

            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003,
                    pathMappings = {
                        --["/var/www/html"] = "${workspaceFolder}", -- Change this as per your project
                    },
                }
            }

            --

            require("nvim-dap-virtual-text").setup {
                -- try to hide api keys and secret
                display_callback = function(variable)
                    local name = string.lower(variable.name)
                    local value = string.lower(variable.value)
                    if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                        return "*****"
                    end

                    if #variable.value > 15 then
                        return " " .. string.sub(variable.value, 1, 15) .. "... "
                    end

                    return " " .. variable.value
                end,
            }


            vim.keymap.set("n", "<leader>bt", function ()
                require('dap-go').debug_test()
            end)

            vim.keymap.set("n", "<leader>bl", function ()
                require('dap-go').debug_last()
            end)

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>bg", dap.run_to_cursor)

            vim.keymap.set("n", "<leader>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<leader>bn", dap.continue)
            vim.keymap.set("n", "<leader>bN", dap.step_into)
            vim.keymap.set("n", "<leader>bj", dap.step_over)
            vim.keymap.set("n", "<leader>bk", dap.step_out)
            vim.keymap.set("n", "<leader>bh", dap.step_back)
            vim.keymap.set("n", "<leader>bb", dap.restart)
            vim.keymap.set("n", "<leader>bu", require("dapui").toggle)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
