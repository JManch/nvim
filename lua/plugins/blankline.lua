return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  main = 'ibl',
  opts = {
    indent = { char = '│' },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        'help',
        'terminal',
        'alpha',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
        'Mason',
        'checkhealth',
        'man',
        'norg',
        '',
      },
    },
  },
}
