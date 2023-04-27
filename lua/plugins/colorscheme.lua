local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
}

function M.config()
    require("catppuccin").setup({
        integrations = {
            nvimtree = true,
            bufferline = true,
            treesitter = true,
            which_key = true,
            gitsigns = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { },
                    hints = { },
                    warnings = { },
                    information = { },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
        }
    })

    vim.cmd.colorscheme("catppuccin-mocha")
end


return M
