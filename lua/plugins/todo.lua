return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTelescope', 'TodoQuickFix', 'TodoLocList' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = true,
  keys = {
    {
      ']t',
      function() require('todo-comments').jump_next() end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function() require('todo-comments').jump_prev() end,
      desc = 'Previous todo comment',
    },
  },
}
