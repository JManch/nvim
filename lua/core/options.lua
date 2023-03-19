local g = vim.g
local o = vim.o
local opt = vim.opt
local api = vim.api

-- General
o.mouse = 'a' -- Enable mouse support
o.exrc = true -- Load vim config in current dir
o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Smart case-sensitive search
o.swapfile = true -- Enable swap files
o.undofile = true -- Store undo history
o.spelllang = 'en_gb'
opt.jumpoptions = { 'stack' }
if vim.version().minor > 8 then
  opt.diffopt:append('linematch:60')
end
g.mapleader = ' ' -- Custom leader
g.maplocalleader = ',' -- Local leader used for neorg
api.nvim_del_keymap('n', '<C-L>') -- Delete clashing keymap

-- UI
o.relativenumber = true -- Show relative line numbers
o.number = true -- Show absolute line number
o.wrap = false -- Disable text wrapping
o.linebreak = true -- Wrap at words rather than characters
o.termguicolors = true -- Enable 24-bit RBG colors
o.scrolloff = 8 -- Scroll before reaching edge
o.signcolumn = 'yes' -- Diagnostic icon column
o.showmode = false -- Hide mode
o.splitright = true -- Vertical split to the right
o.splitbelow = true -- Horizontal split below
o.showtabline = 0 -- Hide tabline
o.list = true -- Show tab, space and new line chars
o.cmdheight = 1 -- Show statusline
o.laststatus = 3 -- Global statusline
o.emoji = false
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.fillchars = { eob = ' ' }
opt.listchars:append({
  trail = '·',
  tab = '  ',
})

-- Tabs, indent and folding
o.expandtab = true -- Use spaces instead of tabs
o.shiftwidth = 4 -- Shift 4 spaces when tab
o.tabstop = 4 -- 1 tab == 4 spaces
o.smartindent = true -- Autoindent new lines
o.foldenable = false -- Disable folding
o.textwidth = 80 -- For comment autowrap

-- Performance
o.hidden = true -- Enable background buffers
o.updatetime = 250 -- Trigger event wait time (ms)
o.timeoutlen = 600 -- Time to wait for mapped sequence (ms)

-- Disable providers
g['loaded_python3_provider'] = 0
g['loaded_node_provider'] = 0
g['loaded_perl_provider'] = 0
