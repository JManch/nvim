local M = {}

M.load = function(bufnr)
    local map = require("core.mappings").map
    local opts = { buffer = bufnr, silent = true }

    local buf = vim.lsp.buf
    map("n", "gH", buf.hover, "Display hover information about symbol", opts)
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

return M
