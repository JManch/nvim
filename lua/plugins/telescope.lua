local M = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
}

M.dependencies = {
    {
        "AckslD/nvim-neoclip.lua",
        config = {
            keys = {
                telescope = {
                    i = {
                        paste_behind = "<C-P>",
                    },
                },
            },
        },
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
}

M.config = function()
    local telescope = require("telescope")

    local options = {
        defaults = {
            layout_config = {
                prompt_position = "top",
            },
            sorting_strategy = "ascending",
            dynamic_preview_title = true,
            mappings = {
                i = {
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                    ["<C-n>"] = "preview_scrolling_down",
                    ["<C-p>"] = "preview_scrolling_up",
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-Down>"] = require("telescope.actions").cycle_history_next,
                    ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
                },
                n = {
                    ["<A-p>"] = require("telescope.actions.layout").toggle_preview,
                    ["<C-n>"] = "preview_scrolling_down",
                    ["<C-p>"] = "preview_scrolling_up",
                    ["<C-Down>"] = require("telescope.actions").cycle_history_next,
                    ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
                },
            },
            preview = {
                timeout = 10,
            }
        },
        pickers = {
            ["find_files"] = {
                follow = true,
            },
            ["buffers"] = {
                previewer = false,
                path_display = { "tail" },
                theme = "dropdown",
                mappings = {
                    n = {
                        ["x"] = require("telescope.actions").delete_buffer,
                    },
                },
            },
            ["registers"] = {
                initial_mode = "insert",
            },
            ["spell_suggest"] = {
                theme = "cursor",
                intitial_mode = "normal",
            },
        },
        extensions = {
            -- Not sure why but some extensions seem to ignore the settings here
            -- whilst for others it works fine. For extensions like workspaces I
            -- have configured the picker in the mapping below.
            ["ui-select"] = require("telescope.themes").get_dropdown(),
            ["file_browser"] = {
                initial_mode = "normal",
                path = "%:p:h",
                grouped = true,
            },
        },
    }

    telescope.setup(options)

    telescope.load_extension("fzf")
    telescope.load_extension("neoclip")
    telescope.load_extension("ui-select")
    telescope.load_extension("workspaces")
    telescope.load_extension("file_browser")
end

M.keys = {
    { "<LEADER>ff", "<CMD>Telescope find_files<CR>", desc = "Find files" },
    { "<LEADER>fa", "<CMD>Telescope find_files no_ignore=true hidden=true<CR>", desc = "Find all files" },
    { "<LEADER>fd", "<CMD>Telescope file_browser<CR>", desc = "File browser" },
    { "<LEADER>fD", "<CMD>Telescope file_browser respect_gitignore=false<CR>", desc = "File browser with git ignore" },
    { "<LEADER>b", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
    { "<LEADER>fg", "<CMD>Telescope live_grep<CR>", desc = "Live grep cwd" },
    { "<LEADER>fG", "<CMD>Telescope grep_string<CR>", desc = "Grep word under cursor in cwd" },
    { "<LEADER>f/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current buffer" },
    { "<leader>fr", "<CMD>Telescope neoclip theme=dropdown initial_mode=normal<CR>", desc = "Neoclip" },
    { "<leader>fR", "<CMD>Telescope registers initial_mode=normal<CR>", desc = "Registers" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>fk", "<CMD>Telescope keymaps<CR>", desc = "Keymaps" },
    { "<leader>fs", "<CMD>Telescope spell_suggest<CR>", desc = "Spell suggestions" },
    { "<leader>fw", "<CMD>Telescope workspaces theme=dropdown previewer=false <CR>", desc = "Workspaces" },
}

return M
