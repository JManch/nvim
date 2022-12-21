local ok, leap = pcall(require, "leap")

if not ok then
    return
end

local leap_spooky

ok, leap_spooky = pcall(require, "leap-spooky")

if not ok then
    return
end

leap.add_default_mappings()

leap_spooky.setup({
    paste_on_remote_yank = true,
})
