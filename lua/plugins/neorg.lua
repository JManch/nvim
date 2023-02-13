return {
  'nvim-neorg/neorg',
  ft = 'norg',
  cmd = { 'Neorg', 'Notes' },
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.norg.concealer'] = {},
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
    require('neorg').setup(opts)
  end,
}
