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
