local M = {
    "ahmedkhalf/project.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope.nvim",
            event = "BufEnter",
            cmd = { "Telescope" }
        }
    },
}


function M.config()
    require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = {
            ".git",
            "Makefile",
            "pyrightconfig.json",
            "package.json",
            "Cargo.lock",
            "Cargo.toml",
            "compile_commands.json",
            "setup.py",
        }
    })

    require("telescope").load_extension("projects")
end


return M
