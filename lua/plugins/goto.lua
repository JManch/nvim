local ok, goto_preview = pcall(require, "goto-preview")

if not ok then
    return
end

local options = {
    width = 120,
    height = 15,
    default_mappings = false,
    resizing_mappings = true,
    opacity = nil,
    focus_on_open = true,
    dismiss_on_move = false,
}

goto_preview.setup(options)
