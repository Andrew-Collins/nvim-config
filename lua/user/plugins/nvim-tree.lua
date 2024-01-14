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
    local wk_mappings = {
      ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    }
    wk.register(wk_mappings, require("user.keymaps").wk_opts)
  end
} }
