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

  { 'brenoprata10/nvim-highlight-colors' },

  { 'godlygeek/tabular', cmd = 'Tabularize' },

  { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } },

  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile' },
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
        -- background_colour = '#000000',
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
    'iamcco/markdown-preview.nvim',
    lazy = false,
    build = function() vim.fn['mkdp#util#install']() end,
  },

  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      -- window = {
      --   blend = 0,
      -- },
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

  {
    'dcampos/nvim-snippy',
    name = 'snippy',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      mappings = {
        is = {
          ['<C-f>'] = 'expand_or_advance',
        },
      },
    },
  },

  {
    'David-Kunz/gen.nvim',
    cmd = 'Gen',
    keys = {
      { '<LEADER>m', '<CMD>Gen Chat<CR>', mode = { 'n' }, desc = 'Gen chat' },
    },
    opts = {
      model = 'qwen2.5-coder:32b-instruct-q3_K_M',
      show_model = true,
      display_mode = 'split',
    },
  },
}
