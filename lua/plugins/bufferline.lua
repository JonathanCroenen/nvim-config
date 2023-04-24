local M = {
    "akinsho/bufferline.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "famiu/bufdelete.nvim",
        event = "VeryLazy"
    }
}


function M.config()
    require("bufferline").setup({
        options = {
            close_command = "Bdelete! %d",
            right_mouse_command = "Bdelete! %d",
            offsets = { { filetype = "NvimTree", text = "", padding = 0 } },
            separator_style = "thin",
            custom_filter = function(buf, _)
                return vim.fn.isdirectory(vim.fn.bufname(buf)) == 0
            end,
        }
    })
end


return M
