return {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.norg.concealer"] = {},
            ["core.presenter"] = {
                config = {
                    zen_mode = "zen-mode"
                }
            },
        },
    },
}
