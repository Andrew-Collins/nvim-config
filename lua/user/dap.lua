local dap = require('dap')
local extension_path = os.getenv("HOME") .. '/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'

-- Keymaps
local wk = require("which-key")
local opts = { prefix = "<leader>", nowait = true }
wk.register({
  ["?"] = { "<cmd>Cheat<CR>", " Cheat.sh" },
  d = {
    name = "+DAP",
    b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
    o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
    i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
    O = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
    B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint" },
    l = { "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log Point" },
    E = { "<cmd>lua require('dap').set_exception_breakpoints()<cr>", "Break Exceptions" },
    e = { "<cmd>lua require('dapui').eval()<cr>", "Eval" },
    U = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
    s = {
      "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustLsp debuggables]] else require'dap'.continue() end<CR>",
      "Start" },
    R = { "<cmd>lua require('dap').run_last()<cr>", "Run Last" },
  },
}, opts)

-- Adapters
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
