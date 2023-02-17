return {
  {
    'JManch/sunset.nvim',
    dependencies = {
      'Shatur/neovim-ayu',
    },
    dev = true,
    lazy = false,
    priority = 1000,
    opts = {
      day_callback = function()
        vim.cmd.colorscheme('ayu-light')
        require('core.utils').set_alacritty_theme(true)
      end,
      night_callback = function()
        vim.cmd.colorscheme('ayu-mirage')
        require('core.utils').set_alacritty_theme(false)
      end,
      update_interval = 10000,
      latitude = 50.8229,
      longitude = -0.1363,
      sunrise_offset = 1800,
      sunset_offset = -1800,
    },
  },
}
