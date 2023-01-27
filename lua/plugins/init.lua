return {
    "nvim-lua/plenary.nvim",

    -- { dir = "~/repos/pomodoro.nvim", lazy = false },

    { "godlygeek/tabular", cmd = "Tabularize" },

    { "folke/twilight.nvim", cmd = { "Twilight" } },

    { "moll/vim-bbye", cmd = { "Bdelete", "Bwipeout" } },

    {
        "windwp/nvim-autopairs",
        event = "BufReadPre",
        config = true,
    },

    { "nvim-tree/nvim-web-devicons", config = true },

    {
        "JManch/sunset.nvim",
        lazy = false,
        opts = {
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
                top_down = true,
            })
            vim.notify = notify
        end,
    },

    {
        "danymat/neogen",
        cmd = "Neogen",
        opts = {
            snippet_engine = "luasnip",
        },
    },

    {
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        opts = {
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
        opts = {
            cmd_name = "LspRename",
        },
    },

    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        opts = {
            window = {
                backdrop = "1",
            },
            plugins = {
                twilight = { enabled = false }
            },
            on_open = function()
                require("lualine").hide()
                vim.o.statusline = " "
            end,
            on_close = function()
                require("lualine").hide({ unhide = true })
            end
        },
        keys = {
            { "<LEADER>z", "<CMD>ZenMode<CR>", desc = "Toggle zen mode" }
        }
    },
}
