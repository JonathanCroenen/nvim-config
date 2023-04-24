local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "arkav/lualine-lsp-progress",
            event = "VeryLazy",
        },
        {
            "nvim-tree/nvim-web-devicons",
            event = "VimEnter"
        }
    },
}

function M.config()
    local lualine = require("lualine")

    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
        "diagnostics",
        sources  = { "nvim_diagnostic" },
        sections = { "error", "warn", "hint" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        colored = true,
        always_visible = true,
    }

    local diff = {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        colored = true,
        cond = hide_in_width,
    }

    local filetype = {
        "filetype",
        icons_enabled = true,
    }

    local progress = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")
        local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
    end

    lualine.setup({
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "▏", right = "▏" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { diff, "branch" },
            lualine_c = { diagnostics, "lsp_progress" },
            lualine_x = { filetype, "encoding", },
            lualine_y = { "location" },
            lualine_z = { progress },
        }
    })
end

return M
