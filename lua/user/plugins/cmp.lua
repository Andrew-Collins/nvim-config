local cmp_setup = function()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end

  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end

  -- 󰃐 󰆩 󰙅 󰛡  󰅲 some other good icons
  local kind_icons = {
    Text = "󰉿",
    Method = "m",
    Function = "󰊕",
    Constructor = "",
    Field = "",
    Variable = "󰆧",
    Class = "󰌗",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰇽",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰊄",
  }
  -- find more here: https://www.nerdfonts.com/cheat-sheet

  cmp.setup {
    snippet = {
      expand = function(args)
        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then
          return
        end
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
      ["<Tab>"] = cmp.mapping(function(fallback)
        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then
          return
        end
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local snip_status_ok, luasnip = pcall(require, "luasnip")
        if not snip_status_ok then
          return
        end
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    -- formatting = {
    --   fields = { "kind", "abbr", "menu" },
    --   -- duplicates = {
    --   --   buffer = 1,
    --   --   path = 1,
    --   --   nvim_lsp = 0,
    --   --   luasnip = 1,
    --   -- },
    --   -- duplicates_default = 0,
    --   format = function(entry, vim_item)
    --     -- Kind icons
    --     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    --     -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    --     vim_item.menu = ({
    --       nvim_lsp = "[LSP]",
    --       luasnip = "[Snippet]",
    --       buffer = "[Buffer]",
    --       path = "[Path]",
    --     })[entry.source.name]
    --     return vim_item
    --   end,
    -- },
    sources = {
      -- { name = 'orgmode' },
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    -- confirm_opts = {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = false,
    -- },
    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
    -- experimental = {
    --   ghost_text = false,
    --   native_menu = false,
    -- },
  }
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

local luasnip_setup = function()
  local snip_status_ok, _ = pcall(require, "luasnip")
  if not snip_status_ok then
    return
  end
  require("luasnip/loaders/from_vscode").lazy_load()
end

return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'super-tab' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}

-- return {
--   {
--     "hrsh7th/nvim-cmp",
--     lazy = false,
--     config = cmp_setup(),
--     dependencies = {
--       "saadparwaiz1/cmp_luasnip", -- snippet completions
--       "hrsh7th/cmp-buffer",       -- buffer completions
--       "hrsh7th/cmp-path",         -- path completions
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-nvim-lsp-signature-help",
--       "hrsh7th/cmp-nvim-lua",
--       {
--         "L3MON4D3/LuaSnip",
--         build = "make install_jsregexp",
--         config = luasnip_setup(),
--         dependencies = {
--           "rafamadriz/friendly-snippets", -- a bunch of snippets to use
--         }
--       },
--     }
--   },
--
-- }
