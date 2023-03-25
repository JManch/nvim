return {
  'lervag/vimtex',
  lazy = false,
  config = function()
    vim.cmd([[
            filetype plugin on
            let g:vimtex_view_general_viewer = 'SumatraPDF'
            let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
            let g:vimtex_matchparen_enabled = 0
            let g:vimtex_format_enabled = 1
            let g:vimtex_compiler_silent = 0
            let g:vimtex_complete_enabled = 0 " use texlab for completion instead
        ]])
  end,
}
