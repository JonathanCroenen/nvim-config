local M = {
    "Shatur/neovim-session-manager",
    event = "VimEnter",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            event = "VimEnter"
        }
    }
}


function M.config()
    local Path = require("plenary.path")
    require("session_manager").setup({
        session_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        autosave_last_session = true,
        autosave_ignore_dirs = {
            "/home/jonathan",
            "/home/jonathan/Downloads",
            "/home/jonathan/Documents",
            "/",
            "/home/jonathan/Music",
            "/home/jonathan/Desktp",
            "/home/jonathan/Pictures",
        },
        autosave_ignore_not_normal = true,
    })
end

return M
