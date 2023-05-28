return {
  'nvim-neorg/neorg',
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
        },
      },
      ['core.keybinds'] = {
        config = {
          hook = function(keybinds)
            -- TODO: Remove these 7 once neorg version 5 releases
            keybinds.unmap('norg', 'n', 'gtd')
            keybinds.unmap('norg', 'n', 'gtu')
            keybinds.unmap('norg', 'n', 'gth')
            keybinds.unmap('norg', 'n', 'gtp')
            keybinds.unmap('norg', 'n', 'gtc')
            keybinds.unmap('norg', 'n', 'gti')
            keybinds.unmap('norg', 'n', 'gtr')
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
