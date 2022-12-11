local ok, neorg = pcall(require, "neorg")

if not ok then
    return
end

local options = {
    lazy_loading = true,
    load = {
        ["core.defaults"] = {},
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
        ["core.norg.concealer"] = {},
    },
}

neorg.setup(options)
