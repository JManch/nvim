return {
  'nvim-neorg/neorg',
  ft = 'norg',
  cmd = { 'Neorg', 'Notes' },
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.norg.concealer'] = {
        config = {
          icon_preset = 'diamond',
        },
      },
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            notes = '~/notes',
          },
          index = 'index.norg',
        },
      },
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
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
