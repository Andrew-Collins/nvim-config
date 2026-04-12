return
{ {
  "smoka7/hop.nvim",
  event = "BufRead",
  config = function()
    local status_ok, hop = pcall(require, "hop")
    if not status_ok then
      return
    end
    hop.setup({ yank_register = '"' })
    -- Keymaps
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    keymap("", "s", "<cmd>HopChar1MW<cr>", opts)
    keymap("", "S", "<cmd>HopWordMW<cr>", opts)
    keymap("", "t",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
      , {})
    keymap("", "T",
      "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
      , {})
    keymap("", "f", "<cmd>HopChar1CurrentLineAC<cr>", opts)
    keymap("", "F", "<cmd>HopChar1CurrentLineBC<cr>", opts)
    -- keymap("", "f", "<cmd>HopYankChar1CurrentLineAC<cr>", {})
    -- keymap("", "F", "<cmd>HopYankChar1CurrentLineBC<cr>", {})

    -- local modes = { "n", "o" }
    -- for _, mode in ipairs(modes) do
    --   keymap(mode, "f",
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
    --     , {})
    --   keymap(mode, "F",
    --     "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
    --     , {})
    -- end
  end,
} }
