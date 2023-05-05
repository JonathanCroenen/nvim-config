local M = {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
}


function M.config()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,
        debounce = 250,
        sources = {
            formatting.black,
            formatting.prettier,
            formatting.stylua,
            formatting.trim_whitespace,
            formatting.clang_format,
            formatting.gofmt,
            formatting.rustfmt,
            diagnostics.todo_comments,
            diagnostics.checkmake,
            diagnostics.eslint,

        }
    })
end


return M
