local M = {
    "goolord/alpha-nvim",
    event = "VimEnter",
}

function M.config()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
        [[                                                    ]],
        [[                                                    ]],
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
        [[                                                    ]],
        [[                                                    ]],
        string.format("version %d.%d.%d", vim.version().major, vim.version().minor, vim.version().patch)
    }

    dashboard.section.buttons.val = {
        dashboard.button("r s", " " .. " Restore Session", "<cmd>SessionManager load_session<CR>"),
        dashboard.button("n f", " " .. " New File", "<cmd>enew<CR>"),
        dashboard.button("f f", " " .. " Find File", "<cmd>Telescope find_files <CR>"),
        dashboard.button("f r", " " .. " Recent Files", "<cmd>Telescope oldfiles <CR>"),
        dashboard.button("f t", " " .. " Find Text", "<cmd>Telescope live_grep <CR>"),
        dashboard.button("e c", " " .. " Edit Config",
            "<cmd>lua local cfg = vim.fn.stdpath('config') vim.cmd.cd(cfg) vim.cmd.edit(cfg)<CR>"),
        dashboard.button("q", " " .. " Quit", "<cmd>qa<CR>"),
    }

    local plugin_stats = require("lazy").stats()
    dashboard.section.footer.val = string.format(
        "%d plugins     %d loaded 󰄬    took %.2f ms 󰥔",
        plugin_stats.count,
        plugin_stats.loaded,
        plugin_stats.startuptime
    )

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
end

return M
