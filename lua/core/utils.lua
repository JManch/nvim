local M = {}

local api = vim.api

M.set_highlights = function()
    api.nvim_set_hl(0, "MatchParen", { link = "Constant" })
    api.nvim_set_hl(0, "NoCursor", { blend = 100, strikethrough = true })
end

local jump_chars = {
    ["("] = true,
    [")"] = true,
    ["["] = true,
    ["]"] = true,
    ["{"] = true,
    ["}"] = true,
    ['"'] = true,
    ["'"] = true,
    ["`"] = true,
    ["<"] = true,
    [">"] = true,
    [","] = true,
    ["."] = true,
}

M.bracket_jump = function()
    local cur_pos = api.nvim_win_get_cursor(0)
    local row = cur_pos[1]
    local col = cur_pos[2]
    local line = api.nvim_get_current_line()
    local sub_line = line:sub(col + 1, #line)

    local jumped = false
    for c in sub_line:gmatch(".") do
        col = col + 1
        if jump_chars[c] ~= nil then
            jumped = true
            api.nvim_win_set_cursor(0, { row, col })
            break
        end
    end
    if not jumped then
        api.nvim_win_set_cursor(0, { row, #line })
    end
end

M.delete_hidden_buffers = function()
    local buffers = api.nvim_list_bufs()
    local ok
    for _, buf in ipairs(buffers) do
        local buf_info = vim.fn.getbufinfo(buf)[1]
        if buf_info.loaded == 0 or (buf_info.hidden == 1 and buf_info.listed == 1) then
            ok, _ = pcall(api.nvim_buf_delete, buf, { force = false })
            if not ok then
                vim.cmd.b(buf)
                return
            end
        end
    end
    vim.notify("Closed all background buffers", "info", { title = "Buffers" })
end

local toggle_table_key = function(table, key, on, off)
    if table[key] ~= off then
        table[key] = off
    else
        table[key] = on
    end
end

M.toggle_g = function(key, on, off)
    toggle_table_key(vim.g, key, on, off)
end

M.toggle_o = function(key, on, off)
    toggle_table_key(vim.o, key, on, off)
end

M.toggle_wo = function(key, on, off)
    toggle_table_key(vim.wo, key, on, off)
end

M.toggle_local_opt = function(key, value)
    if vim.opt_local[key]:get()[value] == nil then
        vim.opt_local[key]:append(value)
    else
        vim.opt_local[key]:remove(value)
    end
end

M.terminal_maps = function()
    local map = require("core.mappings").map
    local opts = { buffer = true }
    local excluded_terminals = {
        "lazygit",
    }

    local buffer_name = vim.api.nvim_buf_get_name(0)
    for _, buffer in ipairs(excluded_terminals) do
        if string.find(buffer_name, buffer, 1, true) then
            if buffer == "lazygit" then
                map("t", "<C-v>", [[<C-\><C-n>"+pA]], "Put from system register", opts)
            end
            return
        end
    end

    map("t", "jk", [[<C-\><C-n>]], "Exit insert mode", opts)
    map("t", "<C-h>", "<CMD>wincmd h<CR>", "Go to the left window", opts)
    map("t", "<C-l>", "<CMD>wincmd l<CR>", "Go to the right window", opts)
    map("t", "<C-j>", "<CMD>wincmd j<CR>", "Go to the down window", opts)
    map("t", "<C-k>", "<CMD>wincmd k<CR>", "Go to the up window", opts)
    map("t", "<C-v>", [[<C-\><C-n>"+pA]], "Put from system register", opts)
end

P = function(v)
    print(vim.inspect(v))
    return v
end

return M
