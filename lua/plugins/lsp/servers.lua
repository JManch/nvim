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
                -- HACK: Need to overwrite on_new_config and clear the new_config.cmd table to fix LSP restarts duplication cmd args
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = { new_config.cmd[1] }
                    table.insert(new_config.cmd, "-z") -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
                    vim.list_extend(new_config.cmd, { "-s", new_root_dir })
                    vim.list_extend(new_config.cmd, { "--hostPID", tostring(vim.fn.getpid()) })
                    table.insert(new_config.cmd, "DotNet:enablePackageRestore=false")
                    vim.list_extend(new_config.cmd, { "--encoding", "utf-8" })
                    table.insert(new_config.cmd, "--languageserver")

                    if new_config.enable_editorconfig_support then
                        table.insert(new_config.cmd, "FormattingOptions:EnableEditorConfigSupport=true")
                    end

                    if new_config.organize_imports_on_format then
                        table.insert(new_config.cmd, "FormattingOptions:OrganizeImports=true")
                    end

                    if new_config.enable_ms_build_load_projects_on_demand then
                        table.insert(new_config.cmd, "MsBuild:LoadProjectsOnDemand=true")
                    end

                    if new_config.enable_roslyn_analyzers then
                        table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableAnalyzersSupport=true")
                    end

                    if new_config.enable_import_completion then
                        table.insert(new_config.cmd, "RoslynExtensionsOptions:EnableImportCompletion=true")
                    end

                    if new_config.sdk_include_prereleases then
                        table.insert(new_config.cmd, "Sdk:IncludePrereleases=true")
                    end

                    if new_config.analyze_open_documents_only then
                        table.insert(new_config.cmd, "RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true")
                    end
                end,
            })
        end,
    }
end

return M
