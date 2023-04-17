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
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
-- keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

M.set_dap_keymaps = function()
  local opts = { prefix = "<leader>", nowait = true }
  wk.register({
    ["?"] = { "<cmd>Cheat<CR>", " Cheat.sh" },
    d = {
      name = "+DAP",
      B = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint" },
      l = { "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Log Point" },
      E = { "<cmd>lua require('dap').set_exception_breakpoints()<cr>", "Break Exceptions" },
      e = { "<cmd>lua require('dapui').eval()<cr>", "Eval" },
      U = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
      s = { "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustDebuggables]] else require'dap'.continue() end<CR>",
        "Start" },
    },
  }, opts)
  -- lvim.builtin.which_key.mappings["dB"] = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
  --   "Set Breakpoint" }
  -- lvim.builtin.which_key.mappings["dl"] = { "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
  --   "Log Point" }
  -- lvim.builtin.which_key.mappings["dE"] = { "<cmd>lua require('dap').set_exception_breakpoints()<cr>",
  --   "Break Exceptions" }
  -- lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
  -- lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  -- lvim.builtin.which_key.mappings["ds"] = {
  --   "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustDebuggables]] else require'dap'.continue() end<CR>",
  --   "Start"
  -- }
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
      -- a = { "<cmd>RustCodeAction<cr>", "Code Action" },
      R = { "<cmd>RustRunnables<cr>", "Rust Runnables" },
      m = { "<Cmd>RustExpandMacro<CR>", "Rust Expand Macro" },
      h = { "<Cmd>RustHoverActions<CR>", "Rust Hover Actions" },
      c = { "<Cmd>RustOpenCargo<CR>", "Open Cargo" },
      -- H = { "<Cmd>RustToggleInlayHints<CR>", "Rust Toggle Inlay Hints" },
    },
  }, opts)
end
return M
