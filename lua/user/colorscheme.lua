-- local colorscheme = "tokyonight"
local colorscheme = "darkplus"
-- local colorscheme = "apprentice"
-- local colorscheme = "alduin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
