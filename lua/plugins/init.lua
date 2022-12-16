local plugins = {

    { "wbthomason/packer.nvim" },

    { "lewis6991/impatient.nvim" },

    { "moll/vim-bbye" },

    { "nvim-lua/plenary.nvim" },

    { "godlygeek/tabular" },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end,
    },

    {
        "ggandor/leap-spooky.nvim",
        config = function()
            require("leap-spooky").setup()
        end,
    },

    {
        "folke/zen-mode.nvim",
        config = function()
            require("plugins.configs.zen")
        end,
    },

    {
        "mfussenegger/nvim-dap",
        config = function()
            require("plugins.configs.dap")
        end,
        disabled = true,
    },

    {
        "JManch/sunset.nvim",
        config = function()
            require("sunset").setup({
                update_interval = 10000,
                latitude = 50.8229,
                longitude = -0.1363,
                sunset_offset = -3600,
                sunrise_offset = 3600,
            })
        end,
        after = "neovim-ayu",
    },

    {
        "Shatur/neovim-ayu",
        config = function()
            local colors = require("ayu.colors")
            colors.generate(true)
            require("ayu").setup({
                mirage = true,
                overrides = function()
                    return { Comment = { fg = colors.comment } }
                end,
            })
            require("core.utils").set_highlights()
            vim.cmd("colorscheme ayu-mirage")
        end,
    },

    {
        "lervag/vimtex",
        config = function()
            -- :h vimtex-faq-nreesitter in regards to treesitter vs vimtex
            -- syntax highlighting. (I'm using treesitter despite downsides)
            vim.cmd([[
                filetype plugin on
                let g:vimtex_view_general_viewer = 'SumatraPDF'
                let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
                let g:vimtex_matchparen_enabled = 0
                let g:vimtex_format_enabled = 1
                let g:vimtex_compiler_silent = 0
                let g:vimtex_complete_enabled = 0 " use texlab for completion instead
                " Disable syntax highlighting, use treesitter instead
                let g:vimtex_syntax_enabled = 0
                let g:vimtex_syntax_conceal_disable = 1
            ]])
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update()
        end,
        requires = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("plugins.configs.treesitter")
        end,
    },

    {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.configs.blankline")
        end,
    },

    {
        "goolord/alpha-nvim",
        config = function()
            require("plugins.configs.alpha")
        end,
    },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.configs.lualine")
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-packer.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        after = {
            "nvim-neoclip.lua",
        },
        config = function()
            require("plugins.configs.telescope")
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.configs.comment")
        end,
    },

    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("plugins.configs.neoclip")
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugins.configs.toggleterm")
        end,
    },

    {
        "natecraddock/workspaces.nvim",
        config = function()
            require("workspaces").setup({
                hooks = {
                    open = function()
                        vim.notify(
                            "Loaded workspace " .. require("workspaces").name(),
                            vim.log.levels.INFO,
                            { title = "Workspaces", timeout = "1000" }
                        )
                        require("sessions").load(nil, { silent = true })
                    end,
                },
            })
        end,
    },

    {
        "natecraddock/sessions.nvim",
        config = function()
            require("sessions").setup({
                session_filepath = vim.fn.resolve(vim.fn.stdpath("data") .. "/sessions"),
                absolute = true,
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.configs.gitsigns")
        end,
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            local notify = require("notify")
            notify.setup({
                fps = 60,
                top_down = true,
            })
            vim.notify = notify
        end,
    },

    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
            })
        end,
    },

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                visual = "<leader>S",
            })
        end,
    },

    {
        "nvim-neorg/neorg",
        after = "nvim-treesitter",
        config = function()
            require("plugins.configs.neorg")
        end,
    },

    {
        "rmagatti/goto-preview",
        config = function()
            require("plugins.configs.goto")
        end,
    },

    {
        "folke/todo-comments.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },

    -- LSP Plugins Below

    {
        "williamboman/mason-lspconfig.nvim",
        after = {
            "mason.nvim",
            "nvim-lspconfig",
            "cmp-nvim-lsp",
            "null-ls.nvim",
        },
        requires = {
            "HallerPatrick/py_lsp.nvim",
            "ray-x/lsp_signature.nvim",
        },
        config = function()
            require("plugins.configs.lsp")
        end,
    },

    { "JManch/nvim-lspconfig" },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        config = function()
            -- HACK: Temporary fix for luasnip snapping me back into old snippets
            -- when pressing tab. Waiting for https://github.com/L3MON4D3/LuaSnip/issues/656
            -- this pr to add an option to exit snip when switching to normal
            -- mode
            local luasnip = require("luasnip")

            local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", {})

            vim.api.nvim_create_autocmd("ModeChanged", {
                group = unlinkgrp,
                pattern = { "s:n", "i:*" },
                desc = "Forget the current snippet when leaving the insert mode",
                callback = function(evt)
                    if
                        luasnip.session
                        and luasnip.session.current_nodes[evt.buf]
                        and not luasnip.session.jump_active
                    then
                        luasnip.unlink_current()
                    end
                end,
            })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        after = { "nvim-autopairs", "LuaSnip" },
        config = function()
            require("plugins.configs.cmp")
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    },

    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                text = {
                    done = "",
                },
                sources = {

                    ltex = {
                        ignore = true,
                    },
                },
            })
        end,
    },

    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({
                cmd_name = "LspRename",
            })
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
            require("plugins.configs.copilot")
        end,
    },
}

require("plugins.packer").load_plugins(plugins)
