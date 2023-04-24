local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
}


function M.config()
    require("indent_blankline").setup({
        char = "┊",
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        use_treesitter = true,
        show_current_context = true,
        buftype_exclude = { "terminal", "nofile" },
        filetype_exclude = { "help", "alpha", "dashboard", "NvimTree" },
    })
end


return M

