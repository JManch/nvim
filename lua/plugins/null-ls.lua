return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufReadPre",
    config = function()
        require("null-ls").setup({
            sources = {
                -- require("null-ls").builtins.formatting.stylua.with({
                --     extra_args = { "--indent-type", "Spaces" },
                -- }),
                require("null-ls").builtins.formatting.black,
                require("null-ls").builtins.code_actions.gitsigns,
                require("null-ls").builtins.formatting.rustfmt,
                require("null-ls").builtins.formatting.clang_format.with({
                    extra_args = { "-style={IndentWidth: 4}" },
                }),
                require("null-ls").builtins.formatting.csharpier,
                require("null-ls").builtins.formatting.prettier.with({
                    filetypes = { "html", "javascript" },
                    extra_args = { "--tab-width", 4 }
                }),
                -- require("null-ls").builtins.code_actions.eslint_d,
                -- require("null-ls").builtins.diagnostics.eslint_d,
            },
            on_attach = require("plugins.lsp.formatting").on_attach
        })
    end,
}
