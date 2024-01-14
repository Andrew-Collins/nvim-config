return { {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { { "nvim-lua/plenary.nvim" } },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end
    harpoon:setup()
    -- Keymaps
    local wk = require("which-key")
    local opts = { noremap = true, silent = true }
    wk.register({
      ["<leader>h"] = {
        name = "Harpoon",
        p = { function() harpoon:list():append() end, "Push" },
        m = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Toggle Quick Menu" },
        a = { function() harpoon:list():select(1) end, "Select 1" },
        s = { function() harpoon:list():select(2) end, "Select 2" },
        d = { function() harpoon:list():select(3) end, "Select 3" },
        f = { function() harpoon:list():select(4) end, "Select 4" },
        h = { function() harpoon:list():prev() end, "Select Prev" },
        l = { function() harpoon:list():next() end, "Select Next" },
      },
    }, opts)
  end
} }
