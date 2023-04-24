local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
}

function M.config()
    vim.cmd.colorscheme("catppuccin-mocha")
end


return M
