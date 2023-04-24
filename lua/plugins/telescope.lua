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
        }
    },
}


function M.config()
    local actions = require("telescope.actions")

    require("telescope").setup({
        defaults = {
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

    require("telescope").load_extension("fzf")
end


return M
