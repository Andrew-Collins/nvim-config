local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "󰌵" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs,     -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { nowait = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

  local wk = require("which-key")

  wk.add({
    {
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<CR>",
      desc = "LSP Goto Declaration",
      nowait = true,
    },
    {
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<CR>",
      desc = "LSP Goto Definition",
      nowait = true,
    },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "LSP GoTo Implementation", nowait = true },
    { "gl", "<cmd>lua vim.lsp.codelens.run()<cr>",       desc = "CodeLens Action",         nowait = true },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>",     desc = "LSP References",          nowait = true },
  })

  -- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

  opts.prefix = "<leader>"
  wk.add({
    { "<leader>l",  group = "LSP",                                      nowait = true },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>",                          desc = "Installer Info",        nowait = true },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols",     nowait = true },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",           desc = "Code Action",           nowait = true },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",           desc = "Document Diagnostics",  nowait = true },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>",      desc = "Format",                nowait = true },
    { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "Info",                  nowait = true },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>",          desc = "Next Diagnostic",       nowait = true },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>",          desc = "Prev Diagnostic",       nowait = true },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",              desc = "CodeLens Action",       nowait = true },
    { "<leader>lo", "<cmd>lua vim.diagnostic.open_float()<CR>",         desc = "Next Diagnostic",       nowait = true },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>",         desc = "Quickfix",              nowait = true },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                desc = "Rename",                nowait = true },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Document Symbols",      nowait = true },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                   desc = "Workspace Diagnostics", nowait = true },
  })
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

return M
