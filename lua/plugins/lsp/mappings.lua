local M = {}

M.load = function(bufnr)
  local map = require('core.mappings').map
  local opts = { buffer = bufnr, silent = true }

  local buf = vim.lsp.buf
  map('n', 'gf', '<CMD>Lspsaga lsp_finder<CR>', 'Open LSP finder', opts)
  map('n', 'gd', '<CMD>Lspsaga goto_definition<CR>', 'Go to LSP symbol definition', opts)
  map('n', 'gdp', '<CMD>Lspsaga peek_definition<CR>', 'Preview LSP symbol definition', opts)
  map('n', 'gD', buf.declaration, 'Go to LSP symbol declaration', opts)
  map('n', 'go', buf.type_definition, 'Go to LSP symbol type definition', opts)
  map('n', 'gr', '<CMD>Telescope lsp_references<CR>', 'View LSP symbol references', opts)
  map('n', 'gh', '<CMD>Lspsaga hover_doc<CR>', 'View LSP symbol help doc', opts)
  map('n', 'ga', '<CMD>Lspsaga code_action<CR>', 'Perform code action on LSP symbol', opts)
  map('n', '<LEADER>rn', '<CMD>Lspsaga rename<CR>', 'Rename LSP symbol', opts)
  map('n', '<LEADER>fl', '<CMD>Telescope lsp_workspace_symbols<CR>', 'LSP workspace symbols', opts)
  map('n', '<LOCALLEADER>o', '<CMD>Lspsaga outline<CR>', 'LSP outline', opts)

  -- Diagnostics
  map('n', 'gl', '<CMD>Lspsaga show_line_diagnostics<CR>', 'Open LSP line diagnostics', opts)
  map('n', ']d', '<CMD>Lspsaga diagnostic_jump_next<CR>', 'Go to next LSP diagnostic', opts)
  map('n', '[d', '<CMD>Lspsaga diagnostic_jump_prev<CR>', 'Go to previous LSP diagnostic', opts)
end

return M
