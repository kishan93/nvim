return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fa',  function() builtin.find_files({ hidden=true, no_ignore = true, prompt_title = 'All Files' }) end, {})

        vim.keymap.set('n', '<leader>fr',  function() builtin.lsp_references({ no_ignore = true, prompt_title = 'LSP References' }) end, {})
        vim.keymap.set('n', '<leader>fd',  function() builtin.lsp_document_symbols({ no_ignore = true, prompt_title = 'LSP Symbols' }) end, {})

        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})



        vim.keymap.set('n', '<leader>fws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>fWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end
}

