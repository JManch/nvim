local M = {
  'rebelot/terminal.nvim',
  cmd = { 'TermOpen', 'Lazygit' },
}

local terminal_height = 0.25
local layouts = {}

setmetatable(layouts, {
  __index = function(_, key)
    local _layouts = {
      float = {
        open_cmd = 'float',
        height = 0.8,
        width = 0.8,
        border = 'rounded',
      },
      window_right = {
        open_cmd = 'belowright vnew',
      },
      screen_right = {
        open_cmd = 'botright vnew',
      },
      screen_bottom = function()
        return {
          open_cmd = 'botright ' .. vim.o.lines * terminal_height .. ' new',
        }
      end,
      window_bottom = function()
        return {
          open_cmd = 'belowright ' .. vim.o.lines * terminal_height .. ' new',
        }
      end,
      window_left = {
        open_cmd = 'aboveleft vnew',
      },
      screen_left = {
        open_cmd = 'topleft vnew',
      },
      window_top = function()
        return {
          open_cmd = 'aboveleft ' .. vim.o.lines * terminal_height .. ' new',
        }
      end,
      screen_top = function()
        return {
          open_cmd = 'topleft ' .. vim.o.lines * terminal_height .. ' new',
        }
      end,
    }
    local value = _layouts[key]
    if type(value) == 'function' then
      return value()
    end
    return value
  end,
})

local function get_cmd(layout_name)
  if vim.fn.has('win32') == 1 then
    if layout_name == 'float' then
      return 'pwsh -nologo -noexit -command winfetch'
    else
      return 'pwsh -nologo'
    end
  else
    return vim.o.shell
  end
end

local function move_terminal(movement)
  local layout = layouts[movement]
  if layout == nil then
    vim.notify('Invalid terminal movement', vim.log.levels.ERROR)
    return
  end

  local count = vim.v.count
  count = count ~= 0 and count or nil

  -- Create a new terminal if one does not exist
  local active_terminals = require('terminal.active_terminals')
  if active_terminals:len() == 0 or (count ~= nil and count > active_terminals:len()) then
    require('terminal.terminal'):new({ layout = layout, cmd = get_cmd(movement) }):open()
    return
  end

  require('terminal').move(count, layout)
end

local function toggle_terminal()
  local count = vim.v.count
  count = count ~= 0 and count or nil

  local get_target_terminal = function(index)
    local active_terminals = require('terminal.active_terminals')
    local terminals = active_terminals:get_sorted_terminals()
    if not terminals then
      return
    end
    if index then
      if index <= active_terminals:len() then
        return terminals[index]
      else
        return
      end
    end
    local target_term = require('terminal').target_term
    if target_term ~= 0 then
      return terminals[target_term]
    end

    local buf_term = active_terminals:get_current_buf_terminal()
    if buf_term then
      return buf_term
    end

    local tab_terminals = active_terminals:get_current_tab_terminals()
    if next(tab_terminals) then
      return tab_terminals[1]
    end

    return terminals[#terminals]
  end

  local term = get_target_terminal(count)
  if term then
    term:toggle()
  else
    require('terminal.terminal'):new({ layout = layouts.float, cmd = get_cmd('float') }):open()
  end
end

M.keys = {
  { '<C-t>', function() toggle_terminal() end, mode = { 'n', 't' }, desc = 'Terminal toggle' },
  { '<LEADER>tl', function() move_terminal('window_right') end, desc = 'Terminal move to right of window' },
  { '<LEADER>tL', function() move_terminal('screen_right') end, desc = 'Terminal move to right of screen' },
  { '<LEADER>tj', function() move_terminal('window_bottom') end, desc = 'Terminal move to bottom of window' },
  { '<LEADER>tJ', function() move_terminal('screen_bottom') end, desc = 'Terminal move to bottom of screen' },
  { '<LEADER>th', function() move_terminal('window_left') end, desc = 'Terminal move to left of window' },
  { '<LEADER>tH', function() move_terminal('screen_left') end, desc = 'Terminal move to left of screen' },
  { '<LEADER>tk', function() move_terminal('window_top') end, desc = 'Terminal move to top of window' },
  { '<LEADER>tK', function() move_terminal('screen_top') end, desc = 'Terminal move to top of screen' },
  { '<LEADER>tf', function() move_terminal('float') end, desc = 'Terminal move to float' },
  { '<C-]>', function() require('terminal.mappings').cycle_next() end, mode = 't', desc = 'Terminal cycle next' },
}

M.config = function()
  local opts = {
    autoclose = true,
  }

  require('terminal').setup(opts)

  local lazygit = require('terminal').terminal:new({
    layout = { open_cmd = 'float', height = 0.9, width = 0.9, border = 'single' },
    cmd = { 'lazygit' },
    autoclose = true,
  })
  vim.api.nvim_create_user_command('Lazygit', function(args)
    lazygit.cwd = args.args and vim.fn.expand(args.args)
    lazygit:toggle(nil, true)
  end, { nargs = '?' })

  -- Append terminal index to buffer name
  vim.api.nvim_create_autocmd('TermOpen', {
    callback = function(params)
      vim.api.nvim_buf_set_name(
        params.buf,
        vim.api.nvim_buf_get_name(params.buf) .. ' ' .. require('terminal').current_term_index()
      )
    end,
    group = vim.api.nvim_create_augroup('TerminalPlugin', {}),
    desc = 'on_term_open',
  })
end

return M
