local M = {}

local api = vim.api

M.set_highlights = function()
    api.nvim_set_hl(0, "MatchParen", {})
    api.nvim_set_hl(0, "WinBar", {})
    api.nvim_set_hl(0, "WinBarNC", {})
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

P = function(v)
    print(vim.inspect(v))
    return v
end

return M
