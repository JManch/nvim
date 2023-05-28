return {
  {
    'nvim-lua/plenary.nvim',
    lazy = false,
    config = function()
      -- NOTE: This doesn't work in the portable neovim windows build or
      -- appimage build because the luajit files are not included for some
      -- reason. The luajit lua files need to be manually copied into
      -- bin/lua/jit. https://github.com/neovim/neovim/issues/15543
      vim.api.nvim_create_user_command(
        'StartProfiling',
        function() require('plenary.profile').start('profile.log', { flame = true }) end,
        {}
      )
      vim.api.nvim_create_user_command('StopProfiling', function() require('plenary.profile').stop() end, {})
    end,
  },

  { 'godlygeek/tabular', cmd = 'Tabularize' },

  { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } },

  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile' },
    enabled = true,
    config = function() require('nvim-autopairs').setup({ map_cr = true }) end,
  },

  { 'nvim-tree/nvim-web-devicons', config = true },

  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      local notify = require('notify')
      notify.setup({
        top_down = true,
      })
      vim.notify = notify
    end,
  },

  {
    'danymat/neogen',
    cmd = 'Neogen',
    opts = {
      snippet_engine = 'luasnip',
    },
  },

  {
    'ggandor/leap.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      {
        'ggandor/leap-spooky.nvim',
        opts = {
          paste_on_remote_yank = true,
        },
      },
    },
    config = function() require('leap').add_default_mappings() end,
  },

  {
    'andweeb/presence.nvim',
    cmd = 'EnablePresence',
    opts = {
      neovim_image_text = 'Neovim',
    },
    config = function(_, opts)
      vim.api.nvim_create_user_command('EnablePresence', function() end, {})
      require('presence').setup(opts)
    end,
  },

  {
    'echasnovski/mini.surround',
    keys = { { '<LEADER>a', mode = { 'n', 'v' } } },
    opts = {
      mappings = {
        add = '<LEADER>aa',
        delete = '<LEADER>ad',
        highlight = '<LEADER>ah',
        replace = '<LEADER>ar',
        update_n_lines = '<LEADER>an',
      },
      n_lines = 20,
    },
  },

  {
    'brenoprata10/nvim-highlight-colors',
    cmd = 'HighlightColorsToggle',
  },

  {
    'iamcco/markdown-preview.nvim',
    lazy = false,
    build = function() vim.fn['mkdp#util#install']() end,
    -- enabled = function() return vim.fn.has('win32') ~= 1 end,
  },

  {
    'j-hui/fidget.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      text = {
        done = '󰄬',
      },
      sources = {
        ltex = {
          ignore = true,
        },
      },
    },
  },
}
