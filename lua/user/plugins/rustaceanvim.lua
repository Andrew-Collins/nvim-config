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
        on_attach = function(client, bufnr)
          require("user.lsp.handlers").on_attach(client, bufnr)
          -- require("user.keymaps").set_rust_keymaps()
        end,
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
    local opts = { noremap = true, buffer = 0 }
    wk.register({
      ["<leader>l"] = {
        R = { "<cmd>RustLsp runnables<cr>", "Rust Runnables" },
        m = { "<Cmd>RustLsp expandMacro<CR>", "Rust Expand Macro" },
        t = { "<Cmd>RustLsp testables<CR>", "Rust Testables" },
        -- h = { "<Cmd>RustLsp hoverActions<CR>", "Rust Hover Actions" },
        c = { "<Cmd>RustLsp openCargo<CR>", "Open Cargo" },
        -- e = { "<Cmd>RustLsp explainError<CR>", "Explain Error" },
      },
    }, opts)
  end,
  ft = { "rust" }
} }
