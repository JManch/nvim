local M = {}

M.servers = function(on_attach, capabilities)
    return {
        -- Override functions below completely override the setup config so
        -- remember to assign on_attach and capabilities
        ["sumneko_lua"] = function()
            require("lspconfig").sumneko_lua.setup({
                on_attach = on_attach,
                capabilities = capabilities,
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
            local capabilities_copy = vim.deepcopy(capabilities)
            capabilities_copy.offsetEncoding = { "utf-16" }
            if vim.fn.has("win32") == 1 then
                require("lspconfig").clangd.setup({
                    on_attach = on_attach,
                    capabilities = capabilities_copy,
                    cmd = {
                        "clangd",
                        "--query-driver=C:\\Users\\Joshua\\scoop\\apps\\mingw\\current\\bin\\g++.exe",
                    },
                })
            else
                require("lspconfig").clangd.setup({
                    on_attach = on_attach,
                    capabilities = capabilities_copy,
                })
            end
        end,
        ["ltex"] = function()
            require("lspconfig").ltex.setup({
                on_attach = on_attach,
                capabilities = capabilities,
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
                    -- HACK: Need to manually define Omnisharp's token types
                    -- because default ones don't match spec https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
                    client.server_capabilities.semanticTokensProvider.legend = {
                        tokenModifiers = { "static" },
                        tokenTypes = {
                            "comment",
                            "excluded",
                            "identifier",
                            "keyword",
                            "keyword",
                            "number",
                            "operator",
                            "operator",
                            "preprocessor",
                            "string",
                            "whitespace",
                            "text",
                            "static",
                            "preprocessor",
                            "punctuation",
                            "string",
                            "string",
                            "class",
                            "delegate",
                            "enum",
                            "interface",
                            "module",
                            "struct",
                            "typeParameter",
                            "field",
                            "enumMember",
                            "constant",
                            "local",
                            "parameter",
                            "method",
                            "method",
                            "property",
                            "event",
                            "namespace",
                            "label",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "xml",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                            "regexp",
                        },
                    }
                    on_attach(client, bufnr)
                end,
                capabilities = capabilities,
            })
        end,
    }
end

return M
