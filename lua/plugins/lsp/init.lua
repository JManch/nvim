local M = {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
}

M.dependencies = {
    "neovim/nvim-lspconfig",
    "ray-x/lsp_signature.nvim",
    "hrsh7th/cmp-nvim-lsp",
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = {
            ui = {
                border = "rounded",
            },
        },
    },
    {
        "folke/neodev.nvim",
        config = {
            library = {
                plugins = false,
            },
        },
    },
}

M.config = function()
    -- Configure LspInfo window border
    local win = require("lspconfig.ui.windows")
    local default_opts = win.default_opts
    win.default_opts = function(options)
        local opts = default_opts(options)
        opts.border = "rounded"
        return opts
    end

    require("plugins.lsp.formatting").setup()
    require("plugins.lsp.diagnostics").setup()

    local mason_config = require("mason-lspconfig")

    mason_config.setup({
        ensure_installed = { "sumneko_lua" },
    })

    local on_attach = function(client, bufnr)
        require("plugins.lsp.formatting").on_attach(client, bufnr)
        require("plugins.lsp.mappings").load(bufnr)
        require("lsp_signature").on_attach({
            max_height = 100,
            max_width = 120,
            doc_lines = 100,
            floating_window = false,
            hint_enable = false,
            hint_prefix = " ",
            toggle_key = "<C-s>",
        }, bufnr)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = vim.tbl_deep_extend("error", {
        function(server_name)
            require("lspconfig")[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    }, require("plugins.lsp.servers").servers(on_attach, capabilities))

    mason_config.setup_handlers(servers)
end

-- Mason Install List

-- stylua (lua)
-- lua-language-server (lua)
-- pyright (python)
-- black (python)
-- clang_format (c++)
-- clangd (c++)
-- csharpier (c#)
-- omnisharp (c#)
-- ltex-ls (spell check for latex + md)
-- texlab (latex)
-- rustfmt (rust)
-- rust-analyzer (rust)

return M
