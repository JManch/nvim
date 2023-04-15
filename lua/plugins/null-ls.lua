return {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local sources = {
      require('null-ls').builtins.formatting.stylua,
      require('null-ls').builtins.formatting.rustfmt,
      require('null-ls').builtins.formatting.csharpier,
    }

    if vim.fn.executable('clang-format') == 1 then
      table.insert(
        sources,
        require('null-ls').builtins.formatting.clang_format.with({
          extra_args = { '-style={IndentWidth: 4}' },
        })
      )
    end

    if vim.fn.executable('black') == 1 then
      table.insert(sources, require('null-ls').builtins.formatting.black)
    end

    if vim.fn.executable('prettier') == 1 then
      table.insert(
        sources,
        require('null-ls').builtins.formatting.prettier.with({
          filetypes = { 'html', 'javascript' },
          extra_args = { '--tab-width', 4 },
        })
      )
    end

    require('null-ls').setup({
      debug = false,
      sources = sources,
      on_attach = require('plugins.lsp.formatting').on_attach,
    })
  end,
}
