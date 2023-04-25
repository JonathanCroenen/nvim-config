local M = {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    cmd = { "Telescope" },
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            event = "VimEnter"
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            event = "VeryLazy",
            build = "make"
        },
        {
            "nvim-telescope/telescope-symbols.nvim",
            event = "VeryLazy",
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
            event = "VeryLazy",
        }
    },
}


function M.config()
    local actions = require("telescope.actions")

    require("telescope").setup({
        defaults = {
            layout_strategy = "horizontal",
            layout_config = {
                prompt_position = "top",
            },
            prompt_prefix = " ",
            selection_caret = "  ",
            sorting_strategy = "ascending",
            path_display = { "smart" },
            file_ignore_patterns = { ".git/", "node_modules/" },
            mappings = {
                i = {
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                }
            }
        }
    })

    local fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
    local fg_alt = vim.api.nvim_get_hl(0, { name = "Function" }).fg
    local bg = vim.api.nvim_get_hl(0, { name = "NormalFloat" }).bg
    local bg_alt = vim.api.nvim_get_hl(0, { name = "Visual" }).bg

    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = bg_alt, bg = bg })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = bg, bg = bg })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = bg })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = bg, bg = fg_alt })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = bg_alt, bg = bg_alt })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = fg, bg = bg_alt })
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = fg_alt, bg = bg_alt })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = bg, bg = fg_alt })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = bg, bg = bg })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = bg })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = bg, bg = bg })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
end


return M
