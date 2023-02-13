local M = {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'HorizontalTerminal', 'VerticalTerminal', 'TerminalFloat' },
}

local toggle_terminal = function(direction, count)
  local cmd = { cmd = 'ToggleTerm', args = { 'direction=' .. direction } }
  if count ~= '' then
    if count ~= tostring(tonumber(count)) then
      print('Invalid argument, must be a number')
      return
    end
    cmd.count = tonumber(count)
  end
  vim.api.nvim_cmd(cmd, {})
end

M.config = function()
  vim.api.nvim_create_user_command('HorizontalTerminal', function(table)
    toggle_terminal('horizontal', table.args)
  end, { nargs = '?' })

  vim.api.nvim_create_user_command('VerticalTerminal', function(table)
    toggle_terminal('vertical', table.args)
  end, { nargs = '?' })

  vim.api.nvim_create_user_command('TerminalFloat', function(table)
    toggle_terminal('float', table.args)
  end, { nargs = '?' })

  local options = {
    open_mapping = [[<C-t>]],
    start_in_insert = true,
    direction = 'float',
    autochdir = true,
    shade_terminals = false,
    persist_mode = false,
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.5
      end
    end,
    float_opts = {
      border = 'curved',
    },
  }

  -- Use powershell on windows
  if vim.fn.has('win32') == 1 then
    options.shell = 'pwsh -nologo -noexit -command winfetch'
  end

  require('toggleterm').setup(options)
end

M.keys = {
  {
    '<C-t>',
    mode = 'n',
    desc = 'Toggle terminal',
  },
  {
    '<LEADER>tg',
    function()
      local Terminal = require('toggleterm.terminal').Terminal
      if M.lazygit == nil then
        M.lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })
      end
      M.lazygit:toggle()
    end,
    desc = 'Lazygit',
  },
  {
    '<LEADER>tG',
    function()
      local Terminal = require('toggleterm.terminal').Terminal
      if M.lazygit_dotfiles == nil then
        M.lazygit_dotfiles =
          Terminal:new({ cmd = 'lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME', hidden = true })
      end
      M.lazygit_dotfiles:toggle()
    end,
    desc = 'Lazygit dotfiles',
  },
  {
    '<LEADER>tv',
    '<CMD>VerticalTerminal<CR>',
    desc = 'Toggle vertical terminal',
  },
  {
    '<LEADER>th',
    '<CMD>HorizontalTerminal<CR>',
    desc = 'Toggle horizontal terminal',
  },
}

return M
