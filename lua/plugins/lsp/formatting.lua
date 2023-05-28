local M = {}

-- Stores the format_on_save option for each filetype. If a filetype is not
-- listed here, format on save will be false although formatting can still be
-- manually invoked. Filetype is the value returned from vim.bo.filetype.
M.format_on_save_filetypes = {
  ['lua'] = { enabled = true, formatter = 'null-ls' },
  ['cs'] = { enabled = false, formatter = 'null-ls' },
  ['javascript'] = { enabled = true, formatter = 'null-ls' },
  ['html'] = { enabled = true, formatter = 'null-ls' },
  ['rust'] = { enabled = true, formatter = 'rust_analyzer' },
}

M.setup = function()
  -- Format on save commands
  vim.api.nvim_create_user_command('ToggleFormatOnSave', function()
    local filetype = vim.bo.filetype
    local formatData = M.format_on_save_filetypes[filetype]
    if formatData == nil then
      vim.notify(
        'Format on save has not be configured for filetype ' .. filetype,
        vim.log.levels.INFO,
        { title = 'Formatting' }
      )
      return
    end
    formatData.enabled = not formatData.enabled
    vim.notify(
      'Format on save for filetype ' .. filetype .. ' set to ' .. tostring(formatData.enabled),
      vim.log.levels.INFO,
      { title = 'Formatting' }
    )
  end, {})

  vim.api.nvim_create_user_command('W', function()
    -- Only filter formatter for know file types
    if M.format_on_save_filetypes[vim.bo.filetype] == nil then
      vim.lsp.buf.format()
    else
      vim.lsp.buf.format({
        filter = function(active_client)
          return active_client.name == M.format_on_save_filetypes[vim.bo.filetype].formatter
        end,
      })
    end

    vim.cmd(':noautocmd w')
  end, {})
end

local group = vim.api.nvim_create_augroup('LspFormatting', {})
M.on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      buffer = bufnr,
      callback = function()
        local formatData = M.format_on_save_filetypes[vim.bo.filetype]

        if formatData == nil or not formatData.enabled then
          return
        end

        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(active_client) return active_client.name == formatData.formatter end,
        })
      end,
    })
  end
end

return M
