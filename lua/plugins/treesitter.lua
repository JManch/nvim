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
          -- Indentation is c_sharp is broken
          disable = { 'python', 'c_sharp' },
        },
        highlight = {
          enable = true,
          disable = { 'latex' },
        },
        context = {
          enable = false,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['in'] = { query = '@number.inner', desc = 'Select inner number text object' },
            },
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'markdown' },
    opts = {
      filetypes = { 'html', 'markdown' },
    },
  },
}
