local ok, neck = pcall(require, "no-neck-pain")

if not ok then
    return
end

local map = require("core.mappings").map

map("n", "<LEADER>n", "<CMD>NoNeckPain<CR>", "Toggle no neck pain")

-- TODO: Waiting for the plugin to wipe the buffers it creates when toggling
-- off. Atm it pollutes the buffer list with loads of unnamed buffers when
-- toggling.

local options = {
    width = 120,
    disableOnLastBuffer = true,
    killAllBuffersOnDisable = false,
    buffers = {
        showName = false,
    },
}

neck.setup(options)
