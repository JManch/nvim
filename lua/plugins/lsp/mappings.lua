local M = {}

M.load = function(client, bufnr)
  local map = require('core.mappings').map
  local lsp_map = function(provider, mode, lhs, rhs, desc, opts)
    local options = { buffer = bufnr, silent = true }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end
    if client.server_capabilities[provider] then
      map(mode, lhs, rhs, desc, options)
    else
      map(
        mode,
        lhs,
        function() vim.notify('Server does not support ' .. provider, vim.log.levels.WARN, { title = client.name }) end,
        desc,
        options
      )
    end
  end

  lsp_map('definitionProvider', 'n', 'gd', vim.lsp.buf.definition, 'LSP symbol definition')
  lsp_map('typeDefinitionProvider', 'n', 'go', vim.lsp.buf.type_definition, 'LSP symbol type definition')
  lsp_map('implementationProvider', 'n', 'gm', vim.lsp.buf.implementation, 'LSP symbol implementation')
  lsp_map('referencesProvider', 'n', 'gr', vim.lsp.buf.references, 'LSP symbol references')
  lsp_map('signatureHelpProvider', 'n', 'gh', vim.lsp.buf.signature_help, 'LSP signature help')
  lsp_map('codeActionProvider', 'n', 'ga', vim.lsp.buf.code_action, 'LSP code action')
  lsp_map('renameProvider', 'n', '<LEADER>rn', vim.lsp.buf.rename, 'LSP rename symbol')

  map('n', 'gD', vim.diagnostic.setqflist, 'LSP open diagnostics quick fix list')
  map('n', 'gl', vim.diagnostic.open_float, 'LSP show line diagnostics')
  map('n', ']d', vim.diagnostic.goto_next, 'LSP goto next diagnostic')
  map('n', '[d', vim.diagnostic.goto_prev, 'LSP goto previous diagnostic')
end

return M
