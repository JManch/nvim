return {
  'numToStr/Comment.nvim',
  opts = {
    mappings = false,
  },
  keys = {
    -- Default mappings
    { 'gc', '<Plug>(comment_toggle_linewise)', desc = 'Comment toggle linewise' },
    { 'gb', '<Plug>(comment_toggle_blockwise)', desc = 'Comment toggle blockwise' },
    {
      'gcc',
      function()
        return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_linewise_current)'
          or '<Plug>(comment_toggle_linewise_count)'
      end,
      desc = 'Comment toggle current line',
      expr = true,
    },
    {
      'gbc',
      function()
        return vim.api.nvim_get_vvar('count') == 0 and '<Plug>(comment_toggle_blockwise_count)'
          or '<Plug>(comment_toggle_blockwise_count)'
      end,
      desc = 'Comment toggle current block',
      expr = true,
    },
    {
      'gc',
      '<Plug>(comment_toggle_linewise_visual)',
      desc = 'Comment toggle linewise visual mode',
      mode = 'x',
    },
    {
      'gb',
      '<Plug>(comment_toggle_blockwise_visual)',
      desc = 'Comment toggle blockwise visual mode',
      mode = 'x',
    },
    {
      'gco',
      function()
        require('Comment.api').insert.linewise.below()
      end,
      desc = 'Comment insert below',
    },
    {
      'gcO',
      function()
        require('Comment.api').insert.linewise.above()
      end,
      desc = 'Comment insert above',
    },
    {
      'gcA',
      function()
        require('Comment.api').insert.linewise.eol()
      end,
      desc = 'Comment insert end of line',
    },

    -- Custom mappings
    { 'gcp', 'yygccp', desc = 'Comment and put below', remap = true, mode = 'n' },
    { 'gcP', 'yygccP', desc = 'Comment and put above', remap = true, mode = 'n' },
    { 'gp', 'ygvgcp', desc = 'Comment and put below', remap = true, mode = 'v' },
    { 'gP', 'ygvgcP', desc = 'Comment and put above', remap = true, mode = 'v' },
  },
}
