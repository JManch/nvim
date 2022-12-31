local M = {}

-- Stores the format_on_save option for each filetype. If a filetype is not
-- listed here, format on save will be false although formatting can still be
-- manually invoked. Filetype is the value returned from vim.bo.filetype
M.format_on_save_filetypes = {
    ["lua"] = true,
    ["cs"] = false,
}

M.setup = function()
    -- Format on save commands
    vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
        local filetype = vim.bo.filetype
        local enabled = M.format_on_save_filetypes[filetype]
        if enabled == nil then
            vim.notify(
                "Format on save has not be configured for filetype " .. filetype,
                vim.log.levels.INFO,
                { title = "null-ls" }
            )
        end
        M.format_on_save_filetypes[filetype] = not enabled
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
end

local group = vim.api.nvim_create_augroup("LspFormatting", {})
M.on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
                local filetype = vim.bo.filetype
                if not M.format_on_save_filetypes[filetype] then
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
end

return M
