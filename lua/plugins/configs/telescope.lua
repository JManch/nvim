local ok, telescope = pcall(require, "telescope")

if not ok then
    return
end

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
telescope.load_extension("live_grep_args")

local map = require("core.mappings").map
map("n", "<LEADER>ff", "<CMD>Telescope find_files<CR>", "Find files")
map("n", "<LEADER>fa", "<CMD>Telescope find_files no_ignore=true hidden=true<CR>", "Find all files")
map("n", "<LEADER>fd", "<CMD>Telescope file_browser<CR>", "File browser")
map("n", "<LEADER>fD", "<CMD>Telescope file_browser respect_gitignore=false<CR>", "File browser with git ignore")
map("n", "<LEADER>fb", "<CMD>Telescope buffers<CR>", "Buffers")
map("n", "<LEADER>fg", "<CMD>Telescope live_grep_args<CR>", "Live grep cwd")
map("n", "<LEADER>fG", "<CMD>Telescope grep_string<CR>", "Grep word under cursor in cwd")
map("n", "<LEADER>f/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer")
map("n", "<leader>fr", "<CMD>Telescope neoclip theme=dropdown initial_mode=normal<CR>", "Neoclip")
map("n", "<leader>fR", "<CMD>Telescope registers initial_mode=normal<CR>", "Registers")
map("n", "<leader>fh", "<CMD>Telescope help_tags<CR>", "Help tags")
map("n", "<leader>fk", "<CMD>Telescope keymaps<CR>", "Keymaps")
map("n", "<leader>fs", "<CMD>Telescope spell_suggest<CR>", "Spell suggestions")
map("n", "<leader>fw", "<CMD>Telescope workspaces theme=dropdown previewer=false <CR>", "Workspaces")
