return {
  'chrisgrieser/nvim-various-textobjs',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    lookForwardLines = 10,
    useDefaultKeymaps = false,
  },
  keys = {
    {
      'in',
      function()
        require('various-textobjs').number(true)
      end,
      mode = { 'o', 'x' },
      desc = 'Inner number text object',
    },
    {
      'an',
      function()
        require('various-textobjs').number(false)
      end,
      mode = { 'o', 'x' },
      desc = 'Around number text object',
    },
    {
      'iv',
      function()
        require('various-textobjs').value(true)
      end,
      mode = { 'o', 'x' },
      desc = 'Inner dict value text object',
    },
    {
      'av',
      function()
        require('various-textobjs').value(false)
      end,
      mode = { 'o', 'x' },
      desc = 'Around dict value text object',
    },
    {
      'ik',
      function()
        require('various-textobjs').key(true)
      end,
      mode = { 'o', 'x' },
      desc = 'Inner dict key text object',
    },
    {
      'ak',
      function()
        require('various-textobjs').key(false)
      end,
      mode = { 'o', 'x' },
      desc = 'Around dict key text object',
    },
    {
      'iS',
      function()
        require('various-textobjs').subword(true)
      end,
      mode = { 'o', 'x' },
      desc = 'Inner subword text object',
    },
    {
      'aS',
      function()
        require('various-textobjs').subword(false)
      end,
      mode = { 'o', 'x' },
      desc = 'Around subword text object',
    },
  },
}
