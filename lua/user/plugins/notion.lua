return { {
  dir = "/home/andrewc/work/notion.nvim/",
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  config = function()
    require("notion").setup()
  end
} }
