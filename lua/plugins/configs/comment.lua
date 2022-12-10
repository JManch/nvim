local ok, comment = pcall(require, "Comment")

if not ok then
    return
end

local options = {
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
}

local map = require("core.mappings").map

map("n", "gcp", "yygccp", "Comment and put below", { remap = true })
map("n", "gcP", "yygccP", "Comment and put above", { remap = true })
map("v", "gp", "ygvgcp", "Comment and put below", { remap = true })
map("v", "gP", "ygvgcP", "Comment and put above", { remap = true })

comment.setup(options)
