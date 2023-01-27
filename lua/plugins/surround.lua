return {
    "echasnovski/mini.surround",
    keys = { { "<LEADER>a", mode = { "n", "v" } } },
    opts = {
        mappings = {
            add = "<LEADER>aa",
            delete = "<LEADER>ad",
            highlight = "<LEADER>ah",
            replace = "<LEADER>ar",
            update_n_lines = "<LEADER>an", -- temporarily set n_lines value
        },
        n_lines = 20, -- lines searched for surround
    },
    config = function(_, opts)
        require("mini.surround").setup(opts)
    end,
}
