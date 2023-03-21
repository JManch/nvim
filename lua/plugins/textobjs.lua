return {
  'chrisgrieser/nvim-various-textobjs',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    lookForwardLines = 10,
    useDefaultKeymaps = false,
  },
  keys = {
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
