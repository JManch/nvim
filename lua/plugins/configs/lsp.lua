local ok, masonconfig = pcall(require, "mason-lspconfig")

if not ok then
    return
end

local lspconfig
ok, lspconfig = pcall(require, "lspconfig")

if not ok then
    return
end

local null
ok, null = pcall(require, "null-ls")

if not ok then
    return
end

local pylsp
ok, pylsp = pcall(require, "py_lsp")

if not ok then
    return
end

-- Mason Install List
-- stylua (lua)
-- lua-language-server (lua)
-- pyright (python)
-- black (python)
-- clang_format (c++)
-- clangd (c++)
-- csharpier (c#)
-- c-sharp-language-server (c#)
-- ltex-ls (spell check for latex + md)
-- texlab (latex)
-- rustfmt (rust)
-- rust-analyzer (rust)

local map = require("core.mappings").map

-- Configure LspInfo window border
local win = require("lspconfig.ui.windows")
local default_opts = win.default_opts
win.default_opts = function(options)
    local opts = default_opts(options)
    opts.border = "rounded"
    return opts
end

-- Stores the format_on_save option for each filetype. If a filetype is not
-- listed here, format on save will be false although formatting can still be
-- manually invoked. Filetype is the value returned from vim.bo.filetype
local format_on_save_filetypes = {
    ["lua"] = true,
    ["cs"] = false,
}
vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
    local filetype = vim.bo.filetype
    local enabled = format_on_save_filetypes[filetype]
    if enabled == nil then
        vim.notify(
            "Format on save has not be configured for filetype " .. filetype,
            vim.log.levels.INFO,
            { title = "null-ls" }
        )
    end
    format_on_save_filetypes[filetype] = not enabled
    vim.notify(
        "Format on save for filetype " .. filetype .. " set to " .. tostring(not enabled),
        vim.log.levels.INFO,
        { title = "null-ls" }
    )
end, {})

vim.api.nvim_create_user_command("W", function()
    vim.lsp.buf.format({
        filter = function(active_client)
            return active_client.name == "null-ls"
        end,
    })
    vim.cmd(":w")
end, {})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_options = {
    sources = {
        null.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
        null.builtins.formatting.black,
        null.builtins.code_actions.gitsigns,
        null.builtins.formatting.rustfmt,
        null.builtins.formatting.clang_format.with({
            extra_args = { "-style={IndentWidth: 4}" },
        }),
        null.builtins.formatting.csharpier,
    },
    -- Auto formatting on save
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    local filetype = vim.bo.filetype
                    if not format_on_save_filetypes[filetype] then
                        return
                    end
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(active_client)
                            return active_client.name == "null-ls"
                        end,
                    })
                end,
            })
        end
    end,
    debug = false,
}

null.setup(null_options)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local lsp_maps = function(bufnr)
    local opts = { buffer = bufnr, silent = true }

    local buf = vim.lsp.buf
    map("n", "H", buf.hover, "Display hover information about symbol", opts)
    map("n", "gd", "<CMD>Telescope lsp_definitions initial_mode=normal<CR>", "Go to symbol definition", opts)
    map("n", "gD", buf.declaration, "Go to symbol declaration", opts)
    map("n", "go", buf.type_definition, "Go to symbol type definition", opts)
    map("n", "gr", "<CMD>Telescope lsp_references<CR>", "View symbol references", opts)
    map("n", "gh", buf.signature_help, "View symbol signature help", opts)
    map("n", "ga", buf.code_action, "Perform code action on symbol", opts)
    map("n", "<LEADER>rn", ":LspRename ", "Rename symbol", opts)
    map("n", "<LEADER>fl", "<CMD>Telescope lsp_workspace_symbols<CR>", "LSP workspace symbols", opts)

    -- Diagnostics
    map("n", "gl", vim.diagnostic.open_float, "Open diagnostic float", opts)
    map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic", opts)
    map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic", opts)

    -- goto-preview mappings
    map("n", "gpd", function()
        require("goto-preview").goto_preview_definition()
    end, "Preview symbol definition", opts)
    map("n", "gpt", function()
        require("goto-preview").goto_preview_type_definition()
    end, "Preview symbol type definition", opts)
    map("n", "gpi", function()
        require("goto-preview").goto_preview_implementation()
    end, "Preview symbol implementation", opts)
    map("n", "gpr", function()
        require("goto-preview").goto_preview_references()
    end, "Preview symbol references", opts)
end

local on_attach = function(_, bufnr)
    lsp_maps(bufnr)

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

local mason_options = {
    ensure_installed = { "sumneko_lua" },
}

masonconfig.setup(mason_options)
masonconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    -- Override functions below completely override the setup config so
    -- remember to assign on_attach and capabilities
    ["sumneko_lua"] = function()
        lspconfig.sumneko_lua.setup({
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
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities_copy,
                cmd = {
                    "clangd",
                    "--query-driver=C:\\Users\\Joshua\\scoop\\apps\\mingw\\current\\bin\\g++.exe",
                },
            })
        else
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities_copy,
            })
        end
    end,
    ["ltex"] = function()
        lspconfig.ltex.setup({
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
        lspconfig.omnisharp.setup({
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
            end,
            capabilities = capabilities,
        })
    end,
})

local pylsp_config = {
    auto_source = false,
    language_server = "pyright", -- Must be installed on system (not through mason)
    on_attach = on_attach,
    capabilities = capabilities,
}
pylsp.setup(pylsp_config)
