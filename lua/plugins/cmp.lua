local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "hrsh7th/cmp-nvim-lua",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "KadoBOT/cmp-plugins",
    },
    event = { "InsertEnter", "CmdlineEnter" },
}

function M.config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    require("cmp-plugins").setup({
        files = { vim.fn.stdpath("config") .. "/lua/plugins/*.lua" },
    })

    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local lspkind = require("lspkind")

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2), { "i", "c" }),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "c" }),
        }),
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = 60,
                ellipsis_char = "...",
                before = function(entry, vim_item) -- places type icons before the completion item
                    if vim.tbl_contains({ "path" }, entry.source.name) then
                        local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
                        if icon then
                            vim_item.kind = icon
                            vim_item.kind_hl_group = hl_group
                        end
                    end
                    return vim_item
                end,
            }),
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp",               max_item_count = 10 },
            { name = "nvim_lua",               max_item_count = 10 },
            { name = "cmp_plugins",            max_item_count = 10 },
            { name = "luasnip",                max_item_count = 5 },
            { name = "nvim_lsp_signature_help" },
        }, {
            { name = "buffer", max_item_count = 10 },
            {
                name = "path",
                option = {
                    trailing_slash = true,
                    get_cwd = vim.loop.cwd,
                },
                max_item_count = 5,
            },
        }),
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })
end

return M
