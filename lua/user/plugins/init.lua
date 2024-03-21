-- All files that require extensive/large config are in their own files
-- These are all plugins with a short config or that need a module, and thus need to be imported manually
return {
  -- General
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "moll/vim-bbye",

  -- Fonts/Icons

  -- Navigation
  "christoomey/vim-tmux-navigator",
  "folke/which-key.nvim",
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        aliases = {
          ["<"] = "t",
        },
      })
    end
  },
  "tpope/vim-repeat",

  -- Colorschemes
  -- use { "folke/tokyonight.nvim" }
  "martinsione/darkplus.nvim",
  -- use { "romainl/apprentice" }
  -- use { "AlessandroYorba/Alduin" }

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason-lspconfig.nvim",

  -- Package Management
  "williamboman/mason.nvim", -- simple to use language server installer

  -- Settings Management
  {
    "tamago324/nlsp-settings.nvim",
    config = function()
      require("nlspsettings").setup({
        config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
        local_settings_dir = ".nlsp-settings",
        local_settings_root_markers_fallback = { '.git' },
        append_default_schemas = true,
        loader = 'json'
      })
    end
  },

  -- DAP
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    'Jarvismkennedy/git-auto-sync.nvim',
    opts = {
      {
        "~/orgfiles",
        auto_pull = true,
        auto_push = true,
        auto_commit = true,
        prompt = true,
        name = "notes"
      },
    },
    lazy = false,
  },

  -- Plugin files that require a module
  require("user.plugins.modules.project").config,
}
