return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  opts = {
    filetype_exclude = {
      'help',
      'terminal',
      'alpha',
      'lspinfo',
      'TelescopePrompt',
      'TelescopeResults',
      'Mason',
      'checkhealth',
      'man',
      '',
    },
    show_trailing_blankline_indent = false,
    show_end_of_line = false,
    show_current_context = false,
  },
}
