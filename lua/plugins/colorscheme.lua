return {
  {
    'JManch/sunset.nvim',
    dependencies = {
      {
        'Shatur/neovim-ayu',
        config = function()
          if os.getenv('ALACRITTY') ~= 'true' then
            local colors = require('ayu.colors')
            colors.generate(true)
            require('ayu').setup({
              overrides = function() return { Comment = { fg = colors.comment } } end,
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
