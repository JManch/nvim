-- Only enable my dev plugins on windows
if vim.fn.has('win32') == 1 then
  return {
    {
      dir = '~/neovim-plugins/tracker.nvim',
      lazy = false,
      config = true,
      enabled = false,
    },
    {
      dir = '~/neovim-plugins/pomodoro.nvim',
      lazy = false,
      config = true,
      enabled = false,
    },
  }
else
  return {}
end
