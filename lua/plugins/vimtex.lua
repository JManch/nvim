return {
  'lervag/vimtex',
  lazy = false,
  config = function()
    vim.cmd('filetype plugin on')
    vim.g.vimtex_matchparen_enabled = 0
    vim.g.vimtex_format_enabled = 1
    vim.g.vimtex_compiler_silent = 0
    vim.g.vimtex_complete_enabled = 0 --[[ use texlab for completion instead ]]

    if os.getenv('NIX_NEOVIM') == '1' then
      vim.g.vimtex_view_method = 'zathura_simple'
    else
      vim.g.vimtex_view_general_viewer = 'SumatraPDF'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    end

    vim.api.nvim_create_autocmd('User', {
      group = vim.api.nvim_create_augroup('vimtex_events', {}),
      pattern = 'VimtexEventViewReverse',
      callback = function() vim.cmd.normal('zz') end,
    })
  end,
}
