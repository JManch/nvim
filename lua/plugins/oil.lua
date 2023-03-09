return {
  'stevearc/oil.nvim',
  cmd = 'OilFloat',
  keys = {
    { '<LEADER>fo', '<CMD>OilFloat<CR>', desc = 'Oil file browser' },
  },
  opts = {
    columns = {
      'icon',
      'mtime',
    },
    win_options = {
      number = true,
      relativenumber = true,
      concealcursor = 'nv',
    },
    keymaps = {
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-x>'] = 'actions.select_split',
      ['gg'] = 'actions.parent',
      ['gh'] = 'actions.toggle_hidden',
      ['q'] = 'actions.close',
    },
    float = {
      padding = 5,
      max_width = 120,
      win_options = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_user_command('OilFloat', function(args)
      if #args.fargs == 0 then
        require('oil').open_float()
      else
        require('oil').open_float(args.fargs[1])
      end
    end, { nargs = '*', complete = 'dir' })
    require('oil').setup(opts)
  end,
}
