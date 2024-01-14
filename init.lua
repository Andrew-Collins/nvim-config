vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.exrc = true
vim.loader.enable()

require "user.options"
require "user.autocommands"
require "user.colorscheme"
require "user.lsp"
require "user.lazy"
require "user.keymaps"
-- require "user.cmp"
-- require "user.telescope"
-- require "user.whichkey"
require "user.dap"
