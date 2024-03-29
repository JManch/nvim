return {
  'JManch/nvim-various-textobjs',
  keys = {
    {
      'iS',
      function() require('various-textobjs').subword(true) end,
      mode = { 'o', 'x' },
      desc = 'Textobjs select inner subword',
    },
    {
      'aS',
      function() require('various-textobjs').subword(false) end,
      mode = { 'o', 'x' },
      desc = 'Textobjs select outer subword',
    },
    {
      'in',
      function() require('various-textobjs').number(true) end,
      mode = { 'o', 'x' },
      desc = 'Textobjs select inner number',
    },
    {
      'an',
      function() require('various-textobjs').number(false) end,
      mode = { 'o', 'x' },
      desc = 'Textobjs select outer number',
    },
  },
}
