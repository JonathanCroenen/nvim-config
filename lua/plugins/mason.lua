local M = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            lazy = true,
        }
    }
}


function M.config()
    require("mason").setup({})
    require("mason-lspconfig").setup({
        ensure_installed = require("config.server-settings.servers"),
        automatic_installation = true,
    })
end



return M

