return {
  'jackMort/ChatGPT.nvim',
  cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions' },
  keys = {
    {
      '<LOCALLEADER>c',
      function()
        require('chatgpt').edit_with_instructions()
      end,
      mode = 'v',
      desc = 'ChatGPT edit selection',
    },
    {
      '<LOCALLEADER>c',
      '<CMD>ChatGPT<CR>',
      desc = 'Open ChatGPT',
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    welcome_message = '',
  },
}
