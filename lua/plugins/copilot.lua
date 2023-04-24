local M  = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
}


function M.config()
    require("copilot").setup({
        panel = {
            enable = false
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 50,
        }
    })
end


return M
