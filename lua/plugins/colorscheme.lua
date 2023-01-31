return {
    {
        "JManch/sunset.nvim",
        dependencies = {
            {
                "Shatur/neovim-ayu",
            },
        },
        dev = true,
        lazy = false,
        priority = 1000,
        opts = {
            day_callback = function()
                vim.cmd.colorscheme("ayu-light")
            end,
            night_callback = function()
                vim.cmd.colorscheme("ayu-mirage")
            end,
            update_interval = 10000,
            latitude = 50.8229,
            longitude = -0.1363,
            sunrise_offset = 1800,
            sunset_offset = -1800,
        },
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        dependencies = {
            "Yazeed1s/oh-lucy.nvim",
            "JoosepAlviste/palenightfall.nvim",
            {
                "sam4llis/nvim-tundra",
                config = true
            },
        },
        cmd = "LoadExtraColorschemes",
        config = function()
            vim.api.nvim_create_user_command("LoadExtraColorschemes",
                function() end, {})
        end
    },
}
