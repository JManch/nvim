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

local terminal_group = api.nvim_create_augroup('Terminal', {})
api.nvim_create_autocmd('TermOpen', {
  group = terminal_group,
  pattern = 'term://*',
  callback = function()
    require('core.mappings').terminal_maps()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.winhl = 'Normal:NormalFloat'
  end,
})

api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'TermOpen' }, {
  group = terminal_group,
  callback = function(args)
    if vim.startswith(vim.api.nvim_buf_get_name(args.buf), 'term://') then
      vim.cmd.startinsert()
    end
  end,
})

api.nvim_create_autocmd('VimLeave', {
  group = api.nvim_create_augroup('ResetTerminalCursor', {}),
  command = 'set guicursor=a:ver80-blinkon500',
  desc = 'Set cursor back to beam for Alacrity when exiting Neovim',
})

-- The following two auto commands set terminal bg to fix border when terminal
-- bg does not match neovim bg
-- https://github.com/neovim/neovim/issues/16572#issuecomment-1954420136
api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

api.nvim_create_autocmd('UILeave', {
  callback = function() io.write('\027]111\027\\') end,
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

api.nvim_create_user_command('ToggleHighlightColors', function() require('nvim-highlight-colors').toggle() end, {})

api.nvim_create_user_command(
  'ToggleVirtualText',
  function() vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text }) end,
  {}
)

api.nvim_create_user_command('PutMessages', function() vim.cmd("put =execute('messages')") end, {})

api.nvim_create_user_command('HighlightGroups', function() vim.cmd.so('$VIMRUNTIME/syntax/hitest.vim') end, {})

api.nvim_create_user_command('SetCWDToFileDir', function() vim.cmd.cd('%:p:h') end, {})
