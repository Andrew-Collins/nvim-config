local M = {}
M.config = function()
  local status_ok, ibl = pcall(require, "ibl")
  if not status_ok then
    return
  end
  ibl.setup(
    {
      enabled = true,
      exclude = {
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
        },
        buftypes = {
          "terminal", "nofile"
        }
      },
      debounce = 100,
      indent = {
        char = "▏",
        highlight = {
          "Function",
          "Label",
        }
      },
      whitespace = { highlight = { "Whitespace", "NonText" } },
      scope = { exclude = { language = { "lua" } } },
    }
  )
end
return M
