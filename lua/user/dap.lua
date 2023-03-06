local dap = require('dap')
local extension_path = os.getenv("HOME") .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}
dap.configurations.rust = {
  {
    name = "Default",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to rust executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    sourceLanguages = { "rust" },
  },
}
require("user.keymaps").set_dap_keymaps()
