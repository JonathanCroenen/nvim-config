local M = {
    "akinsho/nvim-toggleterm.lua",
}

function M.config()
    require("toggleterm").setup({
        size = 10,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        autochdir = true,
        shade_terminals = true,
        shading_factor = -40,
        start_in_insert = true,
        insert_mappings = false,
        terminal_mappings = true,
        persist_mode = true,
        direction = "horizontal",
        auto_scroll = true,
        winbar = {
            enabled = false,
        },
        on_open = function(terminal)
            local ok, nvimtree = pcall(require, "nvim-tree.api")
            if not ok then
                return
            end

            local nvimtree_view = require "nvim-tree.view"
            if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
                local nvimtree_width = vim.fn.winwidth(nvimtree_view.get_winnr())
                nvimtree.tree.toggle()
                nvimtree_view.View.width = nvimtree_width
                nvimtree.tree.toggle({
                    focus = false
                })
            end
        end
    })
end


return M
