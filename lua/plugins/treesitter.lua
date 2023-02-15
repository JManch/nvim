return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSUninstall', 'TSInstall' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        -- BUG: Broken on nightly
        'nvim-treesitter/nvim-treesitter-context',
        enabled = false,
      },
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = { 'lua', 'norg', 'markdown', 'markdown_inline' },
        indent = {
          enable = true,
          -- Treesitter indent does not work well in python yet
          disable = { 'python' },
        },
        highlight = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = { query = '@function.outer', desc = 'Select outer function' },
              ['if'] = { query = '@function.inner', desc = 'Select inner function' },
              ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
              ['ic'] = { query = '@class.inner', desc = 'Select inner class' },
              ['aB'] = { query = '@block.outer', desc = 'Select outer block' },
              ['iB'] = { query = '@block.inner', desc = 'Select inner block' },
              ['ai'] = { query = '@conditional.outer', desc = 'Select outer conditional' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select inner conditional' },
              ['al'] = { query = '@loop.outer', desc = 'Select outer loop' },
              ['il'] = { query = '@loop.inner', desc = 'Select inner loop' },
              ['aa'] = { query = '@call.outer', desc = 'Select outer call' },
              ['ia'] = { query = '@call.inner', desc = 'Select inner call' },
              ['ah'] = { query = '@parameter.outer', desc = 'Select outer parameter' },
              ['ih'] = { query = '@parameter.inner', desc = 'Select inner parameter' },
            },
            include_surrounding_whitespace = false,
          },
          swap = {
            enable = true,
            swap_next = {
              ['<C-f>'] = { query = '@parameter.inner', desc = 'Swap parameter forward' },
              ['<C-y>'] = { query = '@function.outer', desc = 'Swap function forward' },
            },
            swap_previous = {
              ['<C-b>'] = { query = '@parameter.inner', desc = 'Swap parameter backwards' },
              ['<C-e>'] = { query = '@function.outer', desc = 'Swap function backwards' },
            },
          },
        },
        context = {
          enable = false,
        },
      })
    end,
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },
}
