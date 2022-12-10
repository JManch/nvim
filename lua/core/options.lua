local g = vim.g
local o = vim.opt
local api = vim.api

-- General
o.mouse = "a" -- Enable mouse support
o.exrc = true -- Load vim config in current dir
o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Smart case-sensitive search
o.swapfile = true -- Enable swap files
o.undofile = true -- Store undo history
g.mapleader = " " -- Custom leader
g.maplocalleader = "," -- Local leader used for neorg
api.nvim_del_keymap("n", "<C-L>") -- Delete clashing keymap

-- UI
o.completeopt = { "menu", "menuone", "noselect" }
o.relativenumber = true -- Show relative line numbers
o.number = true -- Show absolute line number
o.wrap = false -- Disable text wrapping
o.linebreak = true -- Wrap at words rather than characters
o.termguicolors = true -- Enable 24-bit RBG colors
o.scrolloff = 8 -- Scroll before reaching edge
o.signcolumn = "yes" -- Diagnostic icon column
o.showmode = false -- Hide mode
o.splitright = true -- Vertical split to the right
o.splitbelow = true -- Horizontal split below
o.showtabline = 0 -- Hide tabline
o.list = true -- Show tab, space and new line chars
o.listchars:append("eol:↴") -- Custom new line char
o.listchars:append("trail:·") -- Custom space char
o.listchars:append("tab:  ") -- Custom tab char
o.cmdheight = 0 -- Hide command bar
g.custom_winbar = "%=%m %t" -- Custom winbar

-- Tabs, indent and folding
o.expandtab = true -- Use spaces instead of tabs
o.shiftwidth = 4 -- Shift 4 spaces when tab
o.tabstop = 4 -- 1 tab == 4 spaces
o.smartindent = true -- Autoindent new lines
o.foldenable = false -- Disable folding
o.textwidth = 79 -- 79 is default anyway

-- Performance
o.hidden = true -- Enable background buffers
o.updatetime = 250 -- Trigger event wait time (ms)
o.timeoutlen = 400 -- Time to wait for mapped sequence (ms)
local unused_plugins = {
    "2html_plugin",
    "getscript",
    "man",
    "matchit",
    "matchparen",
    "shada_plugin",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(unused_plugins) do
    g["loaded_" .. plugin] = 1
end
