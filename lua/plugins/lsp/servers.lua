return {
    -- Override functions below completely override the setup config so
    -- remember to assign on_attach and capabilities
    ["sumneko_lua"] = function()
        require("lspconfig").sumneko_lua.setup({
            on_attach = require("plugins.lsp").on_attach,
            capabilities = require("plugins.lsp").capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })
    end,
    ["clangd"] = function()
        local capabilities_copy = vim.deepcopy(require("plugins.lsp").capabilities)
        capabilities_copy.offsetEncoding = { "utf-16" }
        if vim.fn.has("win32") == 1 then
            require("lspconfig").clangd.setup({
                on_attach = require("plugins.lsp").on_attach,
                capabilities = capabilities_copy,
                cmd = {
                    "clangd",
                    "--query-driver=C:\\Users\\Joshua\\scoop\\apps\\mingw\\current\\bin\\g++.exe",
                },
            })
        else
            require("lspconfig").clangd.setup({
                on_attach = require("plugins.lsp").on_attach,
                capabilities = capabilities_copy,
            })
        end
    end,
    ["ltex"] = function()
        require("lspconfig").ltex.setup({
            on_attach = require("plugins.lsp").on_attach,
            capabilities = require("plugins.lsp").capabilities,
            settings = {
                ltex = {
                    language = "en-GB",
                },
            },
        })
    end,
    ["omnisharp"] = function()
        require("lspconfig").omnisharp.setup({
            on_attach = function(client, bufnr)
                require("plugins.lsp").on_attach(client, bufnr)
            end,
            capabilities = require("plugins.lsp").capabilities,
        })
    end,
}
