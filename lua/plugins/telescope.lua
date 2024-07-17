return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    lazy = false,
    keys = {
      { '<LEADER>ff', '<CMD>Telescope find_files<CR>', desc = 'Telescope find files' },
      { '<LEADER>fa', '<CMD>Telescope find_files no_ignore=true hidden=true<CR>', desc = 'Telescope find all files' },
      { '<LEADER><LEADER>', '<CMD>Telescope buffers<CR>', desc = 'Telescope buffers' },
      {
        '<LEADER>fg',
        function() require('telescope').extensions.live_grep_args.live_grep_args() end,
        desc = 'Telescope live grep cwd',
      },
      {
        '<LEADER>fG',
        function() require('telescope-live-grep-args.shortcuts').grep_word_under_cursor() end,
        desc = 'Telescope grep word under cursor in cwd',
      },
      { '<LEADER>fb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', desc = 'Telescope find in current buffer' },
      { '<LEADER>fR', '<CMD>Telescope registers initial_mode=normal<CR>', desc = 'Telescope registers' },
      { '<LEADER>fh', '<CMD>Telescope help_tags<CR>', desc = 'Telescope help tags' },
      { '<LEADER>fk', '<CMD>Telescope keymaps<CR>', desc = 'Telescope keymaps' },
      { '<LEADER>fs', '<CMD>Telescope spell_suggest<CR>', desc = 'Telescope spell suggestions' },
      { '<LEADER>fc', '<CMD>Telescope lsp_document_symbols<CR>', desc = 'Telescope LSP symbols' },
      { '<LEADER>fr', '<CMD>Telescope registers<CR>', desc = 'Telescope registers' },
      { '<LEADER>fm', '<CMD>Telescope marks<CR>', desc = 'Telescope marks' },
      { '<LEADER>f<SPACE>', '<CMD>Telescope resume<CR>', desc = 'Telescope resume last search' },
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
            initial_mode = 'normal',
            path_display = { 'smart' },
            sort_mru = true,
            ignore_current_buffer = true,
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
          ['ui-select'] = require('telescope.themes').get_dropdown(),
          file_browser = {
            initial_mode = 'normal',
            path = '%:p:h',
            grouped = true,
            git_status = false,
          },
        },
      }
      telescope.setup(opts)
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension('live_grep_args')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    cmd = 'TelescopeFileBrowser',
    keys = {
      { '<LEADER>fd', '<CMD>Telescope file_browser<CR>', desc = 'Telescope file browser' },
      {
        '<LEADER>fD',
        '<CMD>Telescope file_browser respect_gitignore=false<CR>',
        desc = 'File browser with git ignore',
      },
    },
    config = function()
      vim.api.nvim_create_user_command('TelescopeFileBrowser', function() vim.cmd('Telescope file_browser') end, {})
      require('telescope').load_extension('file_browser')
    end,
  },
}
