return {
  'nvim-neorg/neorg',
  version = '*',
  cmd = { 'Neorg', 'Notes' },
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {
        config = {
          icon_preset = 'diamond',
        },
      },
      ['core.dirman'] = {
        config = {
          workspaces = {
            notes = '~/files/notes',
            journal = '~/Journal',
          },
        },
      },
      ['core.keybinds'] = {
        config = {
          hook = function(keybinds)
            keybinds.remap_key('norg', 'n', '<M-CR>', '<RIGHT>')
            keybinds.remap_key('norg', 'i', '<M-CR>', '<C-j>')
            keybinds.remap_key('norg', 'n', '<C-Space>', '<LOCALLEADER>t')
          end,
        },
      },
      ['core.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
      ['core.journal'] = {
        config = {
          strategy = 'flat',
          workspace = 'journal',
        },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_user_command('Notes', function()
      vim.cmd('$tabnew')
      vim.cmd('Neorg workspace notes')
    end, {})
    vim.api.nvim_create_user_command('CloseNotes', 'Neorg return', {})
    require('neorg').setup(opts)
  end,
}
