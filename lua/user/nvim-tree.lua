local M = {}
M.config = function()
  require("nvim-tree").setup({
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    diagnostics = {
      enable = true,
    }
  })
end
return M
