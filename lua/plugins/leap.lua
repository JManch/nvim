return {
    "ggandor/leap.nvim",
    event = "BufReadPost",
    dependencies = {
        {
            "ggandor/leap-spooky.nvim",
            opts = {
                paste_on_remote_yank = true,
            },
        },
        {
            "ggandor/flit.nvim",
            opts = {
                labeled_modes = "nv",
            },
        },
    },
    config = function()
        require("leap").add_default_mappings()
    end,
}
