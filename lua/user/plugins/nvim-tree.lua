return
{ {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      diagnostics = {
        enable = true,
      }
    })
    -- Keymaps
    local wk = require("which-key")
    local wk_mappings =
    {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = true, remap = false },
    }
    wk.add(wk_mappings)
  end
} }
