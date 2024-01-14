return
{ {
  "phaazon/hop.nvim",
  event = "BufRead",
  config = function()
    local status_ok, hop = pcall(require, "hop")
    if not status_ok then
      return
    end
    hop.setup()
    -- Keymaps
    local keymap = vim.api.nvim_set_keymap
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
  end,
} }
