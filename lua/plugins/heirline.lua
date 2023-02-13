local M = {
  'rebelot/heirline.nvim',
  lazy = false,
  enabled = false,
}

local setup_colors = function()
  return {
    bright_bg = M.utils.get_highlight('Folded').bg,
    bright_fg = M.utils.get_highlight('Folded').fg,
    red = M.utils.get_highlight('DiagnosticError').fg,
    dark_red = M.utils.get_highlight('DiffDelete').bg,
    green = M.utils.get_highlight('String').fg,
    blue = M.utils.get_highlight('Function').fg,
    gray = M.utils.get_highlight('NonText').fg,
    orange = M.utils.get_highlight('Constant').fg,
    purple = M.utils.get_highlight('Statement').fg,
    cyan = M.utils.get_highlight('Special').fg,
    diag_warn = M.utils.get_highlight('DiagnosticWarn').fg,
    diag_error = M.utils.get_highlight('DiagnosticError').fg,
    diag_hint = M.utils.get_highlight('DiagnosticHint').fg,
    diag_info = M.utils.get_highlight('DiagnosticInfo').fg,
    git_del = M.utils.get_highlight('diffDeleted').fg,
    git_add = M.utils.get_highlight('diffAdded').fg,
    git_change = M.utils.get_highlight('diffChanged').fg,
  }
end

local mode = function()
  return {
    init = function(self)
      self.mode = vim.fn.mode(1)
      if not self.once then
        vim.api.nvim_create_autocmd('ModeChanged', {
          pattern = '*:*o',
          command = 'redrawstatus',
        })
        self.once = true
      end
    end,
    static = {
      mode_names = {
        n = 'NORMAL',
        no = 'OP',
        nov = 'OP',
        noV = 'OP',
        ['no'] = 'OP',
        niI = 'NORMAL',
        niR = 'NORMAL',
        niV = 'NORMAL',
        nt = 'NORMAL',
        v = 'VISUAL',
        V = 'VISUAL LINES',
        [''] = 'VISUAL BLOCK',
        s = 'SELECT',
        S = 'SELECT',
        [''] = 'BLOCK',
        i = 'INSERT',
        ic = 'INSERT',
        ix = 'INSERT',
        R = 'REPLACE',
        Rc = 'REPLACE',
        Rv = 'V-REPLACE',
        Rx = 'REPLACE',
        c = 'COMMAND',
        cv = 'COMMAND',
        ce = 'COMMAND',
        r = 'ENTER',
        rm = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        t = 'TERMINAL',
        ['null'] = 'NONE',
      },
      mode_colors = {
        n = 'red',
        i = 'green',
        v = 'cyan',
        V = 'cyan',
        ['\22'] = 'cyan',
        c = 'orange',
        s = 'purple',
        S = 'purple',
        ['\19'] = 'purple',
        R = 'orange',
        r = 'orange',
        ['!'] = 'red',
        t = 'red',
      },
    },
    provider = function(self)
      return '  %2( ' .. self.mode_names[self.mode] .. '%)'
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_colors[mode], bold = true }
    end,
    update = {
      'ModeChanged',
    },
  }
end

M.config = function()
  M.conditions = require('heirline.conditions')
  M.utils = require('heirline.utils')

  -- local colors = require("kanagawa.colors").setup()
  require('heirline').load_colors(setup_colors())
  vim.api.nvim_create_augroup('Heirline', {})
  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = function()
      local colors = setup_colors()
      M.utils.on_colorscheme(colors)
    end,
  })

  local statusline = { mode() }

  require('heirline').setup({
    statusline = statusline,
  })
end

return M
