return
{ {
  "mrcjkb/rustaceanvim",
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        executor = require("rustaceanvim/executors").termopen, -- can be quickfix or termopen
        reload_workspace_from_cargo_toml = true,
        autosethints = true,
        hover_actions = {
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
          auto_focus = true,
        },
      },
      server = {
        -- on_attach = function(client, bufnr)
        --   require("user.lsp.handlers").on_attach(client, bufnr)
        -- end,
        settings = function(project_root)
          local ra = require('rustaceanvim.config.server')
          local res = ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = '.vscode/settings.json'
          })
          -- vim.print(res)
          return res
        end,
        -- settings = {
        --   ["rust-analyzer"] = {
        --     lens = {
        --       enable = true,
        --     },
        --     cargo = {
        --       extraArgs = {},
        --     },
        --     -- checkOnSave = {
        --     --   command = "clippy",
        --     -- },
        --     -- check = {
        --     --   allTargets = false,
        --     --   targets = "thumbv7em-none-eabihf",
        --     -- }
        --   },
        -- }
      },
      -- No setup here, all done in user.dap
      -- dap = { adapter = false, configuration = false },
    }
    -- Keymaps
    local wk = require("which-key")
    local wk_mappings = {
      {
        { "<leader>lR", "<cmd>RustLsp runnables<cr>",   buffer = 0, desc = "Rust Runnables",    remap = false },
        { "<leader>lc", "<Cmd>RustLsp openCargo<CR>",   buffer = 0, desc = "Open Cargo",        remap = false },
        { "<leader>lm", "<Cmd>RustLsp expandMacro<CR>", buffer = 0, desc = "Rust Expand Macro", remap = false },
        { "<leader>lt", "<Cmd>RustLsp testables<CR>",   buffer = 0, desc = "Rust Testables",    remap = false },
      } }
    wk.add(wk_mappings)
  end,
  ft = { "rust" }
} }
