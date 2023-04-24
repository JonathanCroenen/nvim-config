local M = {
    "RRethy/vim-illuminate",
    event = "VeryLazy"
}


function M.config()
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

    local illuminate = require("illuminate")

    illuminate.configure({
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        delay = 200,
        filetypes_denylist = {
            "dirvish",
            "fugitive",
            "alpha",
            "NvimTree",
            "packer",
            "neogitstatus",
            "Trouble",
            "lir",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "DressingSelect",
            "TelescopePrompt",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
        large_file_cutoff = 10000,
        min_count_to_highlight = 2,
    })

end

return M
