local api = vim.api

local utils = require('core.utils')

api.nvim_create_autocmd('FileType', {
  group = api.nvim_create_augroup('SetFormatOptions', {}),
  pattern = '*',
  callback = function() vim.opt_local.formatoptions:remove('o') end,
})

api.nvim_create_autocmd('ColorScheme', {
  group = api.nvim_create_augroup('SetHighlights', {}),
  pattern = '*',
  callback = utils.set_highlights,
})

api.nvim_create_autocmd('TextYankPost', {
  group = api.nvim_create_augroup('YankHighlight', {}),
  pattern = '*',
  callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 }) end,
})

api.nvim_create_autocmd('TermOpen', {
  group = api.nvim_create_augroup('TerminalMappings', {}),
  pattern = 'term://*',
  callback = function() require('core.mappings').terminal_maps() end,
})

api.nvim_create_user_command('ToggleAutoWrap', function() utils.toggle_local_opt('formatoptions', 't') end, {})

api.nvim_create_user_command('ToggleCommentAutoWrap', function() utils.toggle_local_opt('formatoptions', 'c') end, {})

api.nvim_create_user_command(
  'ToggleParagraphAutoFormat',
  function() utils.toggle_local_opt('formatoptions', 'a') end,
  {}
)

api.nvim_create_user_command('ToggleColorcolumn', function() utils.toggle_wo('colorcolumn', '80', '') end, {})

api.nvim_create_user_command('ToggleCMDHeight', function() utils.toggle_o('cmdheight', 1, 0) end, {})

api.nvim_create_user_command(
  'ToggleVirtualText',
  function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end,
  {}
)

api.nvim_create_user_command('PutMessages', function() vim.cmd("put =execute('messages')") end, {})

api.nvim_create_user_command('HighlightGroups', function() vim.cmd.so('$VIMRUNTIME/syntax/hitest.vim') end, {})
