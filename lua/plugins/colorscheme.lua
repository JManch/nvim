return {
  {
    'JManch/sunset.nvim',
    branch = 'dev',
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
    config = function()
      local opts = {
        day_callback = function()
          vim.cmd.colorscheme('ayu-light')
          require('core.utils').windows_set_alacritty_theme(true)
        end,
        night_callback = function()
          vim.cmd.colorscheme('ayu-mirage')
          require('core.utils').windows_set_alacritty_theme(false)
        end,
        update_interval = 10000,
        latitude = 50.8229,
        longitude = -0.1363,
        sunrise_offset = 1800,
        sunset_offset = -1800,
      }

      if os.getenv('NIX_NEOVIM_DARKMAN') == '1' then
        opts.custom_switch = function(tbl)
          if not tbl.init then
            return
          end
          local result = vim.system({ 'darkman', 'get' }, { text = true }):wait()
          if vim.trim(result.stdout) == 'light' then
            tbl.trigger_day()
          else
            tbl.trigger_night()
          end
        end
      end

      require('sunset').setup(opts)
    end,
  },
}
