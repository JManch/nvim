return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    keys = {
      { '<LEADER>ff', '<CMD>Telescope find_files<CR>', desc = 'Find files' },
      { '<LEADER>fa', '<CMD>Telescope find_files no_ignore=true hidden=true<CR>', desc = 'Find all files' },
      { '<LEADER>b', '<CMD>Telescope buffers<CR>', desc = 'Buffers' },
      { '<LEADER>fg', '<CMD>Telescope live_grep<CR>', desc = 'Live grep cwd' },
      { '<LEADER>fG', '<CMD>Telescope grep_string<CR>', desc = 'Grep word under cursor in cwd' },
      { '<LEADER>fb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', desc = 'Find in current buffer' },
      { '<LEADER>fR', '<CMD>Telescope registers initial_mode=normal<CR>', desc = 'Registers' },
      { '<LEADER>fh', '<CMD>Telescope help_tags<CR>', desc = 'Help tags' },
      { '<LEADER>fk', '<CMD>Telescope keymaps<CR>', desc = 'Keymaps' },
      { '<LEADER>fs', '<CMD>Telescope spell_suggest<CR>', desc = 'Spell suggestions' },
      { '<LEADER>fw', '<CMD>Telescope workspaces theme=dropdown previewer=false <CR>', desc = 'Workspaces' },
      { '<LEADER>fc', '<CMD>Telescope colorscheme<CR>', desc = 'Switch colorscheme' },
      { '<LEADER>f<SPACE>', '<CMD>Telescope resume<CR>', desc = 'Resume last telescope search' },
    },
    config = function()
      local telescope = require('telescope')

      local opts = {
        defaults = {
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
          dynamic_preview_title = true,
          mappings = {
            i = {
              ['<C-S-p>'] = require('telescope.actions.layout').toggle_preview,
              ['<C-n>'] = 'preview_scrolling_down',
              ['<C-p>'] = 'preview_scrolling_up',
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
              ['<C-Down>'] = 'cycle_history_next',
              ['<C-Up>'] = 'cycle_history_prev',
            },
            n = {
              ['<C-S-p>'] = require('telescope.actions.layout').toggle_preview,
              ['<C-n>'] = 'preview_scrolling_down',
              ['<C-p>'] = 'preview_scrolling_up',
              ['<C-Down>'] = 'cycle_history_next',
              ['<C-Up>'] = 'cycle_history_prev',
              ['q'] = 'close',
            },
          },
        },
        pickers = {
          find_files = {
            follow = true,
          },
          buffers = {
            previewer = false,
            path_display = { 'tail' },
            theme = 'dropdown',
            mappings = {
              n = {
                ['x'] = require('telescope.actions').delete_buffer,
              },
            },
          },
          registers = {
            initial_mode = 'insert',
          },
          spell_suggest = {
            theme = 'cursor',
            intitial_mode = 'normal',
          },
          colorscheme = {
            initial_mode = 'normal',
            enable_preview = true,
          },
        },
        extensions = {
          -- Not sure why but some extensions seem to ignore the settings here
          -- whilst for others it works fine. For extensions like workspaces I
          -- have configured the picker in the mapping below.
          ['ui-select'] = require('telescope.themes').get_dropdown(),
          file_browser = {
            initial_mode = 'normal',
            path = '%:p:h',
            grouped = true,
          },
          lazy = {
            show_icon = true,
            mappings = {
              open_in_file_browser = '<C-d>',
            },
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension('workspaces')
    end,
  },
  {
    'AckslD/nvim-neoclip.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<LEADER>fr', '<CMD>Telescope neoclip theme=dropdown initial_mode=normal<CR>', desc = 'Neoclip' },
    },
    opts = {
      keys = {
        telescope = {
          i = {
            paste_behind = '<C-P>',
          },
        },
      },
    },
    config = function(_, opts)
      require('neoclip').setup(opts)
      require('telescope').load_extension('neoclip')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    cmd = 'TelescopeFileBrowser',
    keys = {
      { '<LEADER>fd', '<CMD>Telescope file_browser<CR>', desc = 'File browser' },
      {
        '<LEADER>fD',
        '<CMD>Telescope file_browser respect_gitignore=false<CR>',
        desc = 'File browser with git ignore',
      },
    },
    config = function()
      vim.api.nvim_create_user_command('TelescopeFileBrowser', function()
        vim.cmd('Telescope file_browser')
      end, {})
      require('telescope').load_extension('file_browser')
    end,
  },
  {
    'tsakirist/telescope-lazy.nvim',
    keys = {
      { '<LEADER>fp', '<CMD>Telescope lazy<CR>', desc = 'Browse installed plugins' },
    },
    config = function()
      require('telescope').load_extension('lazy')
    end,
  },
}
