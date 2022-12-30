local ok, toggleterm = pcall(require, "toggleterm")

if not ok then
    return
end

local api = vim.api

local options = {
    open_mapping = [[<C-t>]],
    start_in_insert = false,
    direction = "float",
    autochdir = true,
    shade_terminals = false,
    persist_mode = false,
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
        end
    end,
    float_opts = {
        border = "curved",
    },
}

-- Use powershell on windows
if vim.fn.has("win32") == 1 then
    options.shell = "pwsh -nologo -noexit -command winfetch"
end

toggleterm.setup(options)

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local lazygit_dotfiles = Terminal:new({ cmd = "lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME", hidden = true })

local toggle_terminal = function(direction, count)
    local cmd = { cmd = "ToggleTerm", args = { "direction=" .. direction } }
    if count ~= "" then
        if count ~= tostring(tonumber(count)) then
            print("Invalid argument, must be a number")
            return
        end
        cmd.count = tonumber(count)
    end
    api.nvim_cmd(cmd, {})
end

-- Keymaps
local map = require("core.mappings").map

map("n", "<leader>tg", function()
    lazygit:toggle()
end, "Lazygit terminal")
map("n", "<leader>tG", function()
    lazygit_dotfiles:toggle()
end, "Lazygit dotfiles terminal")
map("n", "<leader>tv", "<CMD>VerticalTerminal<CR>", "Toggle vertical terminal")
map("n", "<leader>th", "<CMD>HorizontalTerminal<CR>", "Toggle horizontal terminal")

local buffer_maps = function()
    local opts = { buffer = true }
    local excluded_buffers = {
        "lazygit",
    }

    -- Abort if buffer is excluded
    local buffer_name = vim.api.nvim_buf_get_name(0)
    for _, buffer in ipairs(excluded_buffers) do
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

-- Commands
api.nvim_create_user_command("HorizontalTerminal", function(table)
    toggle_terminal("horizontal", table.args)
end, { nargs = "?" })

api.nvim_create_user_command("VerticalTerminal", function(table)
    toggle_terminal("vertical", table.args)
end, { nargs = "?" })

api.nvim_create_user_command("TerminalFloat", function(table)
    toggle_terminal("float", table.args)
end, { nargs = "?" })

-- Autocmds
local group = api.nvim_create_augroup("ToggleTerm", {})
api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = "term://*",
    command = "startinsert",
})

api.nvim_create_autocmd("TermOpen", {
    group = group,
    pattern = "term://*",
    callback = function()
        buffer_maps()
        vim.cmd("startinsert")
    end,
})
