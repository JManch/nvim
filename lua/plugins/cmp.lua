local M = {
    "hrsh7th/nvim-cmp",
    event = "BufReadPost",
}

M.dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
}

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.config = function()
    local cmp = require("cmp")

    local options = {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),

            ["<Up>"] = cmp.mapping.select_prev_item(),
            ["<Down>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),

            ["<S-Up>"] = cmp.mapping.scroll_docs(-5),
            ["<S-Down>"] = cmp.mapping.scroll_docs(5),

            ["<C-e>"] = cmp.mapping.abort(),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = vim.tbl_deep_extend("force", cmp.config.window.bordered(), {
                max_height = 15,
                max_width = 60,
            }),
        },
        sources = cmp.config.sources({
            { name = "neorg", keyword_length = 1 },
            { name = "luasnip", keyword_length = 2 },
            { name = "nvim_lsp", keyword_length = 1 },
            { name = "buffer", keyword_length = 3 },
            { name = "path" },
        }),
        formatting = {
            format = require("lspkind").cmp_format({
                mode = "symbol_text",
                maxwidth = 60,
                ellipsis_char = "...",
            }),
        },
        -- view = { waiting for https://github.com/hrsh7th/nvim-cmp/issues/1142
        --     entries = "native",
        -- },
    }

    cmp.setup(options)
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "cmdline" },
            { name = "path" },
        },
    })

    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Insert '(' after selecting a function
    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
end

return M
