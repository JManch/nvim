return {
  'nvim-neorg/neorg',
  ft = 'norg',
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
            notes = '~/notes',
          },
          index = 'index.norg',
        },
      },
      ['core.keybinds'] = {
        config = {
          hook = function(keybinds)
            keybinds.unmap('norg', 'n', '<M-CR>')
            keybinds.unmap('norg', 'i', '<M-CR>')
            keybinds.remap_key('norg', 'n', '<C-Space>', '<LOCALLEADER>t')
          end,
        },
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_user_command('Notes', 'Neorg workspace notes', {})
    vim.api.nvim_create_user_command('CloseNotes', 'Neorg return', {})
    require('neorg').setup(opts)
  end,
}
