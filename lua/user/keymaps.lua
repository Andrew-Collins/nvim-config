local M = {}
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local wk = require("which-key")
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", opts)
keymap("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", opts)
keymap("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", opts)
keymap("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

M.set_dap_keymaps = function()
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
end

M.set_hop_keymaps = function()
  local opts = { noremap = true, silent = true }
  keymap("", "S", "<cmd>HopChar2MW<cr>", opts)
  keymap("", "s", "<cmd>HopWordMW<cr>", opts)
  -- keymap("", "L", "<cmd>HopLineMW<cr>", opts)
  keymap("", "t",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    , {})
  keymap("", "T",
    "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
    , {})

  local modes = { "n", "o" }
  for _, mode in ipairs(modes) do
    keymap(mode, "f",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
      , {})
    keymap(mode, "F",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
      , {})
  end
end

M.set_rust_keymaps = function()
  local opts = { noremap = true, buffer = 0 }
  wk.register({
    ["<leader>l"] = {
      R = { "<cmd>RustLsp runnables<cr>", "Rust Runnables" },
      m = { "<Cmd>RustLsp expandMacro<CR>", "Rust Expand Macro" },
      -- h = { "<Cmd>RustLsp hoverActions<CR>", "Rust Hover Actions" },
      c = { "<Cmd>RustLsp openCargo<CR>", "Open Cargo" },
      -- e = { "<Cmd>RustLsp explainError<CR>", "Explain Error" },
    },
  }, opts)
end
return M
