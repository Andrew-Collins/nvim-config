local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.mason").setup()
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    require("user.lsp.handlers").on_attach(client, args.buf)
  end,
})
