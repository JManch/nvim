local M = {}

M.servers = function(on_attach, capabilities)
  return {
    -- Override functions below completely override the setup config so
    -- remember to assign on_attach and capabilities
    ['lua_ls'] = function()
      require('lspconfig').lua_ls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })
    end,
    ['clangd'] = function()
      local capabilities_copy = vim.deepcopy(capabilities)
      capabilities_copy.offsetEncoding = { 'utf-16' }
      if vim.fn.has('win32') == 1 then
        require('lspconfig').clangd.setup({
          on_attach = on_attach,
          capabilities = capabilities_copy,
          cmd = {
            'clangd',
            '--query-driver=C:\\Users\\Joshua\\scoop\\apps\\mingw\\current\\bin\\g++.exe',
          },
        })
      else
        require('lspconfig').clangd.setup({
          on_attach = on_attach,
          capabilities = capabilities_copy,
        })
      end
    end,
    ['ltex'] = function()
      require('lspconfig').ltex.setup({
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)
          require('ltex_extra').setup({
            load_langs = { 'en-GB' },
            path = '.ltex',
            file_watcher = true,
            log_level = 'none',
          })
        end,
        capabilities = capabilities,
        settings = {
          ltex = {
            language = 'en-GB',
          },
        },
      })
    end,
    ['omnisharp'] = function()
      require('lspconfig').omnisharp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['matlab_ls'] = function()
      require('lspconfig').matlab_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = true,
      })
    end,
    ['nil_ls'] = function()
      require('lspconfig').nil_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['nixd'] = function()
      require('lspconfig').nixd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['rust_analyzer'] = function()
      require('lspconfig').rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['ocamlls'] = function()
      require('lspconfig').ocamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ['pyright'] = function()
      require('lspconfig').pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  }
end

return M
