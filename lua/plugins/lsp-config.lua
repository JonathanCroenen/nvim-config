local M = {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" }
}

function M.config()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Enable some capabilities not included in neovim default capabilities
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local lsp_keymaps = function(bufnr)
        local opts = function(desc)
            return { desc = "lsp: " .. desc, noremap = true, silent = true, buffer = bufnr }
        end

        local keymap = vim.keymap.set
        keymap("n", "gD", vim.lsp.buf.declaration, opts("Go To Declaration"))
        keymap("n", "gd", vim.lsp.buf.definition, opts("Go To Definition"))
        keymap("n", "K", vim.lsp.buf.hover, opts("Hover"))
        keymap("n", "gI", vim.lsp.buf.implementation, opts("Go To Implementations"))
        keymap("n", "gr", vim.lsp.buf.references, opts("Go To References"))
        keymap("n", "gl", vim.diagnostic.open_float, opts("Open Diagnostic Float"))
        keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts("Open Lsp Info"))
        keymap("n", "<leader>lI", "<cmd>Mason<CR>", opts("Open Mason"))
        keymap("n", "<leader>la", vim.lsp.buf.code_action, opts("Code Actions"))
        keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts("Run Formatters"))
        keymap("n", "<leader>lj", function() vim.diagnostic.goto_next({ buffer = 0 }) end, opts("Go To Next Diagnostic"))
        keymap("n", "<leader>lk", function() vim.diagnostic.goto_prev({ buffer = 0 }) end, opts("Go To Prev Diagnostic"))
        keymap("n", "<leader>lr", vim.lsp.buf.rename, opts("Rename"))
        keymap("n", "<leader>lq", vim.diagnostic.setloclist, opts("Set Diagnostic Loc List"))
    end

    local lspconfig = require("lspconfig")
    local on_attach = function(_, bufnr)
        lsp_keymaps(bufnr)
    end

    for _, server in pairs(require("config.server-settings.servers")) do
        local opts = {
            on_attach = on_attach,
            capabilities = capabilities
        }

        server = vim.split(server, "@")[1]
        local ok, conf_opts = pcall(require, "config.server-settings." .. server)
        if ok then
            opts = vim.tbl_deep_extend("force", conf_opts, opts)
        end

        lspconfig[server].setup(opts)
    end

    -- Set icons in sign column
    local set_diagnostic_sign = function(type, icon)
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local symbols = require("config.symbols")
    set_diagnostic_sign("Error", symbols.error)
    set_diagnostic_sign("Warning", symbols.warn)
    set_diagnostic_sign("Information", symbols.info)
    set_diagnostic_sign("Hint", symbols.hint)
end

return M
