return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSUninstall', 'TSInstall' },
    dependencies = { 'windwp/nvim-ts-autotag' },
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = { 'lua', 'norg', 'markdown', 'markdown_inline' },
        indent = {
          enable = true,
          -- Treesitter indent does not work well in python yet
          -- Nix indent randomly broke for some reason. Eventually try enabling
          -- it again.
          disable = { 'python', 'nix' },
        },
        highlight = {
          enable = true,
          disable = { 'latex' },
        },
        autotag = {
          enable = true,
        },
      })
    end,
  },
}
