local M = {
  'JManch/alpha-nvim',
  lazy = false,
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub('%s', ''):gsub('SPC', '<leader>')

  local opts = {
    position = 'center',
    shortcut = sc,
    cursor = 4,
    width = 25,
    align_shortcut = 'right',
    hl = 'CmpItemMenu',
    hl_shortcut = 'CmpItemMenu',
  }

  if keybind then
    opts.keymap = { 'n', sc_, keybind, { noremap = true, silent = true } }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
    vim.api.nvim_feedkeys(key, 'normal', false)
  end

  return {
    type = 'button',
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

M.opts = function()
  local header = {
    type = 'text',
    val = {
      [[       __           __               ]],
      [[      / /___  _____/ /_  __  ______ _]],
      [[ __  / / __ \/ ___/ __ \/ / / / __ `/]],
      [[/ /_/ / /_/ (__  ) / / / /_/ / /_/ / ]],
      [[\____/\____/____/_/ /_/\__,_/\__,_/  ]],
    },
    opts = {
      position = 'center',
      hl = 'GitSignsChange',
    },
  }

  local plugin_count = {
    type = 'text',
    val = '',
    opts = {
      position = 'center',
      hl = 'CmpItemMenu',
    },
  }

  local version = {
    type = 'text',
    val = string.match(vim.api.nvim_exec('version', true), 'NVIM (.-)\n'),
    opts = {
      position = 'center',
      hl = 'CmpItemMenu',
    },
  }

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    callback = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      plugin_count.val = '  ' .. stats.count .. ' plugins (' .. ms .. 'ms)'
    end,
  })

  local buttons = {
    type = 'group',
    val = {
      button('e', '   New file', '<CMD>ene <BAR> startinsert<CR>'),
      button('f', '   Find file', '<CMD>Telescope find_files<CR>'),
      button('d', '   Browse files', '<CMD>TelescopeFileBrowser<CR>'),
      button('w', '   Load workspace', '<CMD>Telescope workspaces theme=dropdown previewer=false<CR>'),
      button('l', '   Toggle theme', '<CMD>SunsetToggle<CR>'),
      button('q', '   Quit', '<CMD>qa<CR>'),
    },
    opts = {
      position = 'center',
      spacing = 1,
    },
  }

  local marginTopPercent = 0.20
  local winheight = vim.fn.winheight(0)
  local headerPadding = vim.fn.max({ 2, vim.fn.floor(winheight * marginTopPercent) })

  local opts = {
    layout = {
      { type = 'padding', val = headerPadding },
      header,
      { type = 'padding', val = 2 },
      buttons,
      { type = 'padding', val = 1 },
      plugin_count,
      { type = 'padding', val = 2 },
      version,
    },
    opts = {
      margin = 0,
    },
  }

  return opts
end

M.config = function(_, opts)
  require('alpha').setup(opts)

  local group = vim.api.nvim_create_augroup('Alpha', {})
  -- Hide cursor when Alpha is opened
  vim.api.nvim_create_autocmd({ 'User' }, {
    group = group,
    pattern = 'AlphaReady',
    callback = function()
      if not vim.tbl_contains(vim.opt.guicursor:get(), 'a:NoCursor') then
        vim.opt.guicursor:append('a:NoCursor')
        vim.api.nvim_create_autocmd('BufLeave', {
          pattern = '<buffer>',
          callback = function()
            vim.opt.guicursor:remove('a:NoCursor')
            return true
          end,
        })
      end
    end,
  })

  -- Hide cursor when toggling between Alpha and other buffers
  vim.api.nvim_create_autocmd('BufEnter', {
    group = group,
    callback = function()
      if vim.bo.filetype ~= 'alpha' then
        return
      end
      if not vim.tbl_contains(vim.opt.guicursor:get(), 'a:NoCursor') then
        vim.opt.guicursor:append('a:NoCursor')
        vim.api.nvim_create_autocmd('BufLeave', {
          pattern = '<buffer>',
          callback = function()
            vim.opt.guicursor:remove('a:NoCursor')
            return true
          end,
        })
      end
    end,
  })
end

return M
