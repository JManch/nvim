local M = {}

M.map = function(mode, lhs, rhs, desc, opts)
  local options = { desc = desc }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local map = M.map
local utils = require('core.utils')

map('i', 'jk', '<ESC>', 'Exit insert mode')
map('i', '<C-b>', '<ESC>^i', 'Jump to beginning of line')
map('i', '<C-e>', '<END>', 'Jump to end of line')
map('i', '<S-Tab>', utils.bracket_jump, 'Jump out of things')

map('n', '<C-h>', '<C-w>h', 'Go to the left window')
map('n', '<C-l>', '<C-w>l', 'Go to the right window')
map('n', '<C-j>', '<C-w>j', 'Go to the down window')
map('n', '<C-k>', '<C-w>k', 'Go to the up window')

map('n', '<S-j>', '<C-o>', 'Go to old cursor position')
map('n', '<S-k>', '<C-i>', 'Go to newer cursor position')

map('n', ']q', '<CMD>cn<CR>', 'Go to next item in quickfix list')
map('n', '[q', '<CMD>cp<CR>', 'Go to previous item in quickfix list')

map('n', 'vv', 'v$', 'Visual select to end of line')

map('n', '<S-e>', 'ge', 'Go to end of previous word')

map({ 'n', 'v' }, '<S-h>', '^', 'Go to start of line')
map({ 'n', 'v' }, '<S-l>', '$', 'Go to end of line')

map('n', '<C-d>', '<C-d>zz', 'Scroll down half a page and centre cursor')
map('n', '<C-u>', '<C-u>zz', 'Scroll up half a page and centre cursor')
map('n', '<C-o>', '<C-o>zz', 'Go to prev marker and centre cursor')
map('n', '<C-i>', '<C-i>zz', 'Go to next marker and centre cursor')

map('n', '<LEADER>v', '<CMD>vsplit<CR><C-l>', 'Vertical split current buffer')
map('n', '<S-x>', '<CMD>Bwipeout<CR>', 'Close current buffer')
map('n', '<S-z>', utils.delete_hidden_buffers, 'Close all hidden buffers')
map('n', 'ZZ', '<CMD>wa<CR><CMD>qa<CR>', 'Write all buffers and quit all')

map('n', '<LEADER>y', '"+y', 'Yank to system register')
map('n', '<LEADER>Y', '"+y$', 'Yank till end of line to system register')
map('n', '<LEADER>p', '"+p', 'Put from system register')
map('n', '<LEADER>P', '"+P', 'Put before from system register')

map('n', '<LEADER>o', 'o<ESC>', 'Create new line below')
map('n', '<LEADER>O', 'O<ESC>', 'Create new line above')

map('n', '<LEADER>c', '<CMD>nohl<CR>', 'Clear search highlighting')

map('n', '<LEADER>l', '<CMD>SunsetToggle<CR>', 'Toggle sunset theme')
map('n', '<LEADER>n', '<CMD>ToggleCMDHeight<CR>', 'Toggle cmdheight')

map('v', '<LEADER>y', '"+y', 'Yank to system register')
map('v', '<LEADER>p', '"+p', 'Put from system register')
map('v', '<LEADER>P', '"+P', 'Put before from system register')

map('v', 'gy', 'ygv<ESC>', 'Yank and maintain cursor position')

M.terminal_maps = function()
  local opts = { buffer = true }
  local excluded_terminals = {
    'lazygit',
    'typioca',
  }

  local buffer_name = vim.api.nvim_buf_get_name(0)
  for _, buffer in ipairs(excluded_terminals) do
    if string.find(buffer_name, buffer, 1, true) then
      if buffer == 'lazygit' then
        map('t', '<C-v>', [[<C-\><C-n>"+pA]], 'Put from system register', opts)
      end
      return
    end
  end

  map('t', 'jk', [[<C-\><C-n>]], 'Exit insert mode', opts)
  map('t', '<C-h>', '<CMD>wincmd h<CR>', 'Go to the left window', opts)
  map('t', '<C-l>', '<CMD>wincmd l<CR>', 'Go to the right window', opts)
  map('t', '<C-j>', '<CMD>wincmd j<CR>', 'Go to the down window', opts)
  map('t', '<C-k>', '<CMD>wincmd k<CR>', 'Go to the up window', opts)
  map('t', '<C-v>', [[<C-\><C-n>"+pA]], 'Put from system register', opts)
end

return M
