local M = {
  'williamboman/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}

M.dependencies = {
  'neovim/nvim-lspconfig',
  'ray-x/lsp_signature.nvim',
  'barreiroleo/ltex_extra.nvim',
  'hrsh7th/cmp-nvim-lsp',
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = false,
      },
      override = function(root_dir, library)
        if string.find(root_dir, 'neovim-plugins') then
          library.enabled = true
        end
      end,
    },
  },
}

M.config = function()
  require('lspconfig.ui.windows').default_options.border = 'rounded'

  require('plugins.lsp.formatting').setup()
  require('plugins.lsp.diagnostics').setup()

  local mason_config = require('mason-lspconfig')

  mason_config.setup()

  local on_attach = function(client, bufnr)
    require('plugins.lsp.formatting').on_attach(client, bufnr)
    require('plugins.lsp.mappings').load(client, bufnr)
    require('lsp_signature').on_attach({
      max_height = 100,
      max_width = 120,
      doc_lines = 100,
      floating_window = false,
      hint_enable = false,
      hint_prefix = '󰅲 ',
      toggle_key = '<C-s>',
    }, bufnr)
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local servers = vim.tbl_deep_extend('error', {
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }, require('plugins.lsp.servers').servers(on_attach, capabilities))

  mason_config.setup_handlers(servers)
end

-- Mason Install List

-- stylua (lua)
-- lua-language-server (lua)
-- pyright (python)
-- black (python)
-- clang_format (c++)
-- clangd (c++)
-- csharpier (c#)
-- omnisharp (c#)
-- ltex-ls (spell check for latex + md)
-- texlab (latex)
-- rustfmt (rust)
-- rust-analyzer (rust)

return M
