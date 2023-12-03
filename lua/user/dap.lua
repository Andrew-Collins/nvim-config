local dap = require('dap')
local extension_path = os.getenv("HOME") .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'

require("user.keymaps").set_dap_keymaps()

dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}
-- dap.adapters.rt_lldb = dap.adapters.lldb
-- dap.adapters["probe-rs-debug"] = {
--   -- type = 'executable',
--   type = 'server',
--   port = "${port}",
--   executable = {
--     command = 'probe-rs',
--     args = { "dap-server", "--port", "${port}" },
--   }
-- }
-- require("dap").set_log_level("DEBUG")
local default_rust = { {
  name = "Default",
  type = "lldb",
  request = "launch",
  program = function()
    return vim.fn.input('Path to rust executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
  sourceLanguages = { "rust" },
} }
-- local type_table = {}
-- type_table["probe-rs-debug"] = { "rust" }
-- type_table["lldb"] = { "rust", "c", "cpp" }
-- require('dap.ext.vscode').load_launchjs(nil, type_table)
-- if next(dap.configurations.rust) == nil then
--   dap.configurations.rust = default_rust
-- end

-- vim.print(dap.configurations.rust)
-- if dap.configurations["probe-rs-debug"] == nil then
--   dap.configurations.rt_lldb = dap.adapters.codelldb
-- else
--   dap.configurations.rt_lldb = dap.adapters["probe-rs-debug"]
-- end
