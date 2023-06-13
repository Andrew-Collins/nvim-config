local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" }  -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs", config = function()
    require("user.autopairs").config()
  end } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim", config = function()
    require("user.comment").config()
  end }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "nvim-tree/nvim-web-devicons" }
  use { "nvim-tree/nvim-tree.lua", config = function()
    require("user.nvim-tree").config()
  end }
  use { "akinsho/bufferline.nvim", config = function()
    require("user.bufferline").config()
  end }
  use { "moll/vim-bbye" }
  use { "nvim-lualine/lualine.nvim", config = function()
    require("user.lualine").config()
  end }
  use { "akinsho/toggleterm.nvim", config = function()
    require("user.toggleterm").config()
  end }
  use { "ahmedkhalf/project.nvim", config = function()
    require("user.project").config()
  end }
  use { "lewis6991/impatient.nvim", config = function()
    require("impatient").enable_profile()
  end }
  use { "lukas-reineke/indent-blankline.nvim", config = function()
    require("user.indentline").config()
  end }
  use { "goolord/alpha-nvim", config = function()
    require("user.alpha").config()
  end }
  use { "folke/which-key.nvim" }

  -- Colorschemes
  -- use { "folke/tokyonight.nvim" }
  use { "martinsione/darkplus.nvim" }
  -- use { "romainl/apprentice" }
  -- use { "AlessandroYorba/Alduin" }

  -- Cmp
  use { "hrsh7th/nvim-cmp" }         -- The completion plugin
  use { "hrsh7th/cmp-buffer" }       -- buffer completions
  use { "hrsh7th/cmp-path" }         -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- Snippets
  use { "L3MON4D3/LuaSnip" }             --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" }   -- enable LSP
  use { "williamboman/mason.nvim" } -- simple to use language server installer
  use { "williamboman/mason-lspconfig.nvim" }
  use { "RRethy/vim-illuminate" }

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }
  use { "junegunn/fzf", run = './install --bin' }
  use { "ibhagwan/fzf-lua", requires = { 'nvim-tree/nvim-web-devicons' } }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", config = function()
    require("user.treesitter").config()
  end }

  -- Git
  use { "lewis6991/gitsigns.nvim", config = function()
    require("user.gitsigns").config()
  end }
  use {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust-tools").config()
    end,
    ft = { "rust", "rs" },
  }
  use {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("user.dapui").config()
    end,
    ft = { "c", "cpp", "python", "rust", "go" },
    event = "BufReadPost",
    requires = { "mfussenegger/nvim-dap" },
  }
  use {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("user.hop").config()
    end,
  }
  use { "kylechui/nvim-surround", tag = "*", config = function()
    require("nvim-surround").setup({
      aliases = {
            ["<"] = "t",
      },
    })
  end
  }
  use {
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
  }
  use { "tpope/vim-repeat" }
  use { "p00f/nvim-ts-rainbow" }

  use { "nvim-treesitter/nvim-treesitter-context", config = function()
    require("treesitter-context").setup({
      enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })
  end }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
