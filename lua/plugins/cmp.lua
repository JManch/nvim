return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'BufReadPost', 'BufNewFile', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dcampos/cmp-snippy',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require('cmp')
      local options = {
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args) require('snippy').expand_snippet(args.body) end,
        },
        mapping = {
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),

          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),

          ['<S-Up>'] = cmp.mapping.scroll_docs(-5),
          ['<S-Down>'] = cmp.mapping.scroll_docs(5),

          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = vim.tbl_deep_extend('force', cmp.config.window.bordered(), {
            max_height = 15,
            max_width = 60,
          }),
        },
        sources = cmp.config.sources({
          { name = 'neorg' },
          { name = 'snippy', keyword_length = 3 },
          { name = 'nvim_lsp', keyword_length = 1 },
          { name = 'path' },
        }),
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 60,
            ellipsis_char = '...',
            before = function(entry, vim_item)
              if entry.source.name == 'nvim_lsp' then
                vim_item.menu = '[' .. entry.source.source.client.name .. ']'
              else
                vim_item.menu = '[' .. entry.source.name .. ']'
              end
              return vim_item
            end,
          }),
        },
      }

      cmp.setup(options)
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline' },
          { name = 'path' },
        },
      })
    end,
  },
  {
    'uga-rosa/cmp-dictionary',
    cmd = { 'LoadDictionaryCompletion', 'ToggleDictionaryCompletion' },
    config = function()
      vim.api.nvim_create_user_command('LoadDictionaryCompletion', function() end, {})

      local source = { name = 'dictionary', keyword_length = 5, max_item_count = 10 }
      local sources = require('cmp').get_config().sources
      table.insert(require('cmp').get_config().sources, source)
      require('cmp').setup.buffer({ sources = sources })

      vim.api.nvim_create_user_command('ToggleDictionaryCompletion', function()
        sources = require('cmp').get_config().sources
        local disabled = false
        for i = #sources, 1, -1 do
          if sources[i].name == 'dictionary' then
            table.remove(sources, i)
            disabled = true
          end
        end
        if not disabled then
          table.insert(sources, #sources + 1, source)
          vim.notify('Enabled dictionary completion', vim.log.levels.INFO)
        else
          vim.notify('Disabled dictionary completion', vim.log.levels.INFO)
        end
        require('cmp').setup.buffer({ sources = sources })
      end, {})
    end,
  },
}
