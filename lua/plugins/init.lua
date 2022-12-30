return {
    "moll/vim-bbye",
    "nvim-lua/plenary.nvim",
    "godlygeek/tabular",
    "folke/twilight.nvim",
    "windwp/nvim-autopairs",

    { "nvim-tree/nvim-web-devicons", config = true },

    {
        "JManch/sunset.nvim",
        lazy = false,
        config = {
            update_interval = 10000,
            latitude = 50.8229,
            longitude = -0.1363,
            sunset_offset = -3600,
            sunrise_offset = 3600,
        },
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            local notify = require("notify")
            notify.setup({
                fps = 30,
                top_down = true,
            })
            vim.notify = notify
        end,
    },

    {
        "danymat/neogen",
        cmd = "Neogen",
        config = {
            snippet_engine = "luasnip",
        },
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = {
            visual = "<leader>S",
        },
    },

    {
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        config = {
            text = {
                done = "",
            },
            sources = {
                ltex = {
                    ignore = true,
                },
            },
        },
    },

    {
        "smjonas/inc-rename.nvim",
        cmd = "LspRename",
        config = {
            cmd_name = "LspRename",
        },
    },
}
