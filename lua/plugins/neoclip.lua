local ok, neoclip = pcall(require, "neoclip")

if not ok then
    return
end

local options = {
    keys = {
        telescope = {
            i = {
                paste_behind = "<C-P>",
            },
        },
    },
}

neoclip.setup(options)
