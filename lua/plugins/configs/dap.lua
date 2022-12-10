local ok, dap = pcall(require, "dap")

if not ok then
    return
end

local map = require("core.mappings").map

map("n", "<LEADER>dr", function()
    dap.repl.open()
end, "Dap open REPL")
map("n", "<LEADER>dc", function()
    dap.continue()
end, "Dap continue debugging or run new debug")
map("n", "<LEADER>db", function()
    dap.toggle_breakpoint()
end, "Toggle dap breakpoint")
map("n", "<LEADER>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Set dap breakpoint")
map("n", "<LEADER>dl", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Dap set log point")
map("n", "<LEADER>ds", function()
    dap.step_over()
end, "Dap step over")
map("n", "<LEADER>di", function()
    dap.step_into()
end, "Dap step into function")
map("n", "<LEADER>do", function()
    dap.step_out()
end, "Dap step out of function")

if vim.fn.has("win32") == 1 then
    dap.adapters.unity = {
        type = "executable",
        command = "mono",
        args = { [[C:\Users\Joshua\scoop\persist\vscode\data\extensions\unity.unity-debug-3.0.2\bin\UnityDebug.exe]] },
    }
    dap.configurations.cs = {
        {
            type = "unity",
            request = "attach",
            name = "Unity Editor",
        },
    }
end
