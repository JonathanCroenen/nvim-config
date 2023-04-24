-- Make command info windows close with just q
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
        vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true, buffer = true })
        vim.o.buflisted = false
    end
})


-- Quit vim if the only window left is toggle-term terminal or nvim-tree or both
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    nested = true, -- also trigger other autocommands that might be the result of this one
    pattern = "NvimTree*",
    callback = function()
        if vim.fn.winnr("$") == 1 then
            vim.cmd.quit()
        end
    end
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    nested = true, -- probably only works with nvim-tree on the left and toggleterm on the bottom
    pattern = "term://*",
    callback = function()
        if vim.fn.winnr("$") == 2 then
            vim.cmd.quit()
        end
    end
})


-- Show a highlight of the yanked text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
    end
})


-- Workaround to get nvim-tree to open when opening nvim with 'nvim "directory"'
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("nvim_tree_open", {}),
    callback = function(ctx)
        local api = require("nvim-tree.api")
        if vim.fn.isdirectory(ctx.file) == 1 then
            vim.cmd.enew()
            api.tree.open({ path = ctx.file })
        end
    end
})


-- Enters insert mode automatically when jumping into a terminal
vim.api.nvim_create_autocmd({ "TermEnter", "BufEnter" }, {
    pattern = "term://*",
    callback = function()
        vim.cmd.startinsert()
    end
})
