local dap = require('dap')
local extension_path = os.getenv("HOME") .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local cpptools_path = os.getenv("HOME") .. '/.local/share/nvim/mason/bin/' .. 'OpenDebugAD7'

-- Keymaps
local wk = require("which-key")
local opts = { prefix = "<leader>", nowait = true }
wk.add({
  { "<leader>?", "<cmd>Cheat<CR>", desc = " Cheat.sh", nowait = true },
  { "<leader>d", group = "DAP", nowait = true },
  { "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Set Breakpoint", nowait = true },
  { "<leader>dE", "<cmd>lua require('dap').set_exception_breakpoints()<cr>", desc = "Break Exceptions", nowait = true },
  { "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out", nowait = true },
  { "<leader>dR", "<cmd>lua require('dap').run_last()<cr>", desc = "Run Last", nowait = true },
  { "<leader>dU", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI", nowait = true },
  { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = true },
  { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue", nowait = true },
  { "<leader>de", "<cmd>lua require('dapui').eval()<cr>", desc = "Eval", nowait = true },
  { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into", nowait = true },
  { "<leader>dl", "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", desc = "Log Point", nowait = true },
  { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over", nowait = true },
  { "<leader>ds", "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustLsp debuggables]] else require'dap'.continue() end<CR>", desc = "Start", nowait = true },
})

-- Adapters
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cpptools_path,
}
dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}
dap.adapters["probe-rs-debug"] = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'probe-rs',
    args = { "dap-server", "--port", "${port}" },
  }
}

-- Load configs from .vscode file
local type_table = {}
type_table["lldb"] = { "rust", "c", "cpp" }
type_table["cppdbg"] = { "rust", "c", "cpp" }
require('dap.ext.vscode').load_launchjs(nil, type_table)


-- if next(dap.configurations.rust) == nil then
--   dap.configurations.rust = default_rust
-- end

-- vim.print(dap.configurations.rust)
-- if dap.configurations["probe-rs-debug"] == nil then
--   dap.configurations.rt_lldb = dap.adapters.codelldb
-- else
--   dap.configurations.rt_lldb = dap.adapters["probe-rs-debug"]
-- end
