return {
  'nvim-lua/plenary.nvim',

  { 'godlygeek/tabular', cmd = 'Tabularize' },

  { 'moll/vim-bbye', cmd = { 'Bdelete', 'Bwipeout' } },

  {
    'folke/twilight.nvim',
    cmd = { 'Twilight' },
    opts = {
      context = 0,
    },
  },

  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
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
    'kkharji/sqlite.lua',
    config = function()
      if vim.fn.has('win32') == 1 then
        vim.g.sqlite_clib_path = vim.fn.stdpath('data') .. '/sqlite3.dll'
      end
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
    'Eandrju/cellular-automaton.nvim',
    keys = {
      { '<LEADER>rr', '<CMD>CellularAutomaton make_it_rain<CR>', desc = 'Make it rain' },
    },
  },

  {
    'jcdickinson/wpm.nvim',
    cmd = 'ToggleWPM',
    config = function()
      vim.api.nvim_create_user_command('ToggleWPM', function()
        require('core.utils').toggle_g('wpm', true, false)
      end, {})
      require('wpm').setup({})
    end,
    init = function()
      vim.g.wpm = false
    end,
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
    config = function()
      require('leap').add_default_mappings()
    end,
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
        update_n_lines = '<LEADER>an', -- temporarily set n_lines value
      },
      n_lines = 20, -- lines searched for surround
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end,
  },

  {
    'brenoprata10/nvim-highlight-colors',
    cmd = 'HighlightColorsToggle',
  },
}
