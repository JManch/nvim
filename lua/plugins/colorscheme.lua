return {
  {
    'JManch/sunset.nvim',
    dependencies = {
      {
        'JManch/neovim-ayu',
        config = function()
          if os.getenv('ALACRITTY') ~= 'true' then
            local colors = require('ayu.colors')
            colors.generate(true)
            require('ayu').setup({
              overrides = {
                Comment = { fg = colors.comment },
              },
            })
          end
        end,
      },
    },
    lazy = false,
    priority = 1000,
    opts = {
      day_callback = function()
        vim.cmd.colorscheme('ayu-light')
        require('core.utils').linux_set_alacritty_theme()
      end,
      night_callback = function()
        vim.cmd.colorscheme('ayu-mirage')
        require('core.utils').windows_set_alacritty_theme(false)
        require('core.utils').linux_set_alacritty_theme()
      end,
      update_interval = 10000,
      latitude = 50.8229,
      longitude = -0.1363,
      sunrise_offset = 1800,
      sunset_offset = -1800,
    },
  },
}
