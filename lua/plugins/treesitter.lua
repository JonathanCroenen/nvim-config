local M = {
    "nvim-treesitter/nvim-treesitter",
    version = false,    -- last release is way too old 
    event = { "BufReadPre", "BufNewFile" },
}


function M.build()
    require("nvim-treesitter.install").update({ with_sync = true })
end


function M.config()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        context_commentstring = { enable = true, enable_autocmd = false },
        autopairs = { enable = true }
    })
end


return M


