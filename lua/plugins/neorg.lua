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
      -- Disabled cause it's slow on windows and I never use it
      ['core.completion'] = {
        config = {
          engine = nil,
        },
      },
      ['core.keybinds'] = {
        config = {
          hook = function(keybinds)
            keybinds.unmap('norg', 'n', '<M-CR>')
            keybinds.unmap('norg', 'i', '<M-CR>')
            keybinds.remap_key('norg', 'n', 'gtd', '<LOCALLEADER>td')
            keybinds.remap_key('norg', 'n', 'gtu', '<LOCALLEADER>tu')
            keybinds.remap_key('norg', 'n', 'gth', '<LOCALLEADER>th')
            keybinds.remap_key('norg', 'n', 'gtp', '<LOCALLEADER>tp')
            keybinds.remap_key('norg', 'n', 'gtc', '<LOCALLEADER>tc')
            keybinds.remap_key('norg', 'n', 'gti', '<LOCALLEADER>ti')
            keybinds.remap_key('norg', 'n', 'gtr', '<LOCALLEADER>tr')
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
