if vim.g.neovide ~= true then
    return
end

local g = vim.g
local o = vim.o
local map = require("core.mappings").map
local utils = require("core.utils")

map("n", "<M-CR>", function()
    utils.toggle_g("neovide_fullscreen", true, false)
end, "Neovide toggle fullscreen")

map("n", "<LEADER>np", function()
    utils.toggle_g("neovide_profiler", true, false)
end, "Neovide toggle profiler")

map("n", "<A-=>", function()
    g.neovide_scale_factor = g.neovide_scale_factor + 0.1
end, "Neovide increase scale")

map("n", "<A-->", function()
    g.neovide_scale_factor = g.neovide_scale_factor - 0.1
end, "Neovide decrease scale")

map("n", "<M-r>", function()
    utils.toggle_g("neovide_refresh_rate", 165, 60)
    vim.notify(
        "Set refresh rate to " .. g.neovide_refresh_rate,
        vim.log.levels.INFO,
        { title = "Neovide", timeout = 2000 }
    )
end, "Neovide toggle refresh rate")

map("n", "<M-t>", function()
    vim.notify(os.date("%X"), vim.log.levels.INFO, { title = "Time", timeout = 2000 })
end, "Neovide view current time")

vim.api.nvim_create_user_command("ToggleAnimations", function()
    utils.toggle_g("neovide_cursor_animation_length", 0.06, 0)
    utils.toggle_g("neovide_cursor_trail_size", 0.4, 0)
    utils.toggle_g("neovide_cursor_vfx_mode", "railgun", "")
end, {})

o.winblend = 0
o.pumblend = 0
o.guifont = string.format("%s:h%s", "FiraCode NFM", 16)
if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
    g.neovide_refresh_rate = 165
end
g.neovide_hide_mouse_when_typing = true
g.neovide_remember_window_size = true
g.neovide_floating_opacity = 0.6
g.neovide_floating_blur_amount_x = 3
g.neovide_floating_blur_amount_y = 3
g.neovide_cursor_animation_length = 0
g.neovide_cursor_trail_size = 0
g.neovide_cursor_vfx_mode = ""
g.neovide_cursor_particle_density = 10
g.neovide_confirm_quit = false
