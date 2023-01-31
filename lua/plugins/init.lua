return {
    "nvim-lua/plenary.nvim",

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
        "kkharji/sqlite.lua",
        config = function()
            if vim.fn.has("win32") == 1 then
                vim.g.sqlite_clib_path = vim.fn.stdpath("data") .. "/sqlite3.dll"
            end
        end
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

    {
        "Eandrju/cellular-automaton.nvim",
        keys = {
            { "<LEADER>rr", "<CMD>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" }
        }
    },

    {
        "jcdickinson/wpm.nvim",
        cmd = "ToggleWPM",
        config = function()
            vim.api.nvim_create_user_command("ToggleWPM", function()
                require("core.utils").toggle_g("wpm", true, false)
            end, {})
            require("wpm").setup({})
        end,
        init = function()
            vim.g.wpm = false
        end
    },

    {
        "kwakzalver/duckytype.nvim",
        cmd = "DuckyType",
        opts = {
            window_config = {
                border = "rounded"
            },
            highlight = {
                good = "String",
                bad = "DiagnosticError",
                remaining = "Comment",
            }
        }
    }
}
