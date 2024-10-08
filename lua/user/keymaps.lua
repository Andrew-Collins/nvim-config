local M = {}
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local wk = require("which-key")
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

M.wk_opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

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

-- keymap("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", opts)
-- keymap("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", opts)
-- keymap("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", opts)
-- keymap("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


local wk_mappings = {
  { "<leader>T", "<cmd>terminal<CR>", desc = "Open Terminal", nowait = true, remap = false },
  { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer",  nowait = true, remap = false },
  { "<leader>w", "<cmd>w!<CR>",       desc = "Save",          nowait = true, remap = false },
}

wk.add(wk_mappings)

-- Lazy
local wk_mappings = {
  { "<leader>L",  group = "Lazy",         nowait = true,   remap = false },
  { "<leader>Ls", "<cmd>Lazy sync<cr>",   desc = "Sync",   nowait = true, remap = false },
  { "<leader>Lu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },
}
wk.add(wk_mappings)

return M
