local M = {
    "kevinhwang91/nvim-ufo",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
        "kevinhwang91/promise-async",
    }
}

function M.config()
    require("ufo").setup({
        provider_selector = function(_, _, _)
            return { "lsp", "treesitter" }
        end
    })
end



return M
