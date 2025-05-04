local dap = require("dap")
dap.adapters.lldb = { type = 'executable', command = 'lldb-vscode' }
dap.configurations.rust = {
  {
    name = "Debug",
    type = "lldb",
    request = "launch",
    program = function() return vim.fn.input("Path to executable: ", "./target/debug/", "file") end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
