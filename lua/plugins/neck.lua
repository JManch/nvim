-- TODO: Waiting for this plugin to wipe the buffers it creates when toggling
-- off. Atm it pollutes the buffer list with loads of unnamed buffers when
-- toggling.

return {
    "shortcuts/no-neck-pain.nvim",
    config = {
        width = 120,
        disableOnLastBuffer = true,
        killAllBuffersOnDisable = false,
        buffers = {
            showName = false,
        },
    },
    keys = {
        { mode = "n", "<LEADER>n", "<CMD>NoNeckPain<CR>", desc = "Toggle no neck pain" },
    },
}
