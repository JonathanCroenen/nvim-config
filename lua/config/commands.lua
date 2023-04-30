
vim.api.nvim_create_user_command("UpdateAll", function()
    vim.notify("Updating plugins ...", vim.log.levels.INFO, {
        title = "Neovim",
    })

    require("lazy").sync({
        wait = false,
        show = false,
    })

    vim.notify("Updating language servers ...", vim.log.levels.INFO, {
        title = "Neovim",
    })

    require("mason-registry").update()

    vim.notify("Updating treesitter parsers ...", vim.log.levels.INFO, {
        title = "Neovim",
    })

    vim.cmd.TSUpdate()

    vim.notify("Update complete", vim.log.levels.INFO, {
        title = "Neovim",
    })
end, { nargs = 0 })
