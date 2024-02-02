-- Automatically install orgfiles
local job = require('plenary.job')
local org_path = vim.env.HOME .. "/orgfiles"
if not vim.loop.fs_stat(org_path) then
  job:new({
    command = 'git',
    args = {
      "clone",
      "git@github.com:Andrew-Collins/orgfiles.git",
      org_path,
    },
    on_exit = function(j, exit_code)
      local res = table.concat(j:result(), "\n")
      if exit_code ~= 0 then
        print("Cloned orgfiles")
      else
        print("Unable to clone orgfiles", res)
      end
    end,
  }):start()
end
-- local async = require "plenary.async"
-- local orgfiles_clone =
--     function()
--       if not vim.loop.fs_stat(org_path) then
--         vim.fn.system({
--           "git",
--           "clone",
--           "git@github.com:Andrew-Collins/orgfiles.git",
--           org_path,
--         })
--       end
--     end
--
-- async.run(orgfiles_clone, function() vim.notify("Cloned orgfiles") end)

return { {
  'nvim-orgmode/orgmode',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter', lazy = true },
  },
  event = 'VeryLazy',
  config = function()
    -- Load treesitter grammar for org
    require('orgmode').setup_ts_grammar()

    -- Setup treesitter
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
      },
      ensure_installed = { 'org' },
    })

    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = org_path .. "/**/*",
      org_default_notes_file = org_path .. "/refile.org",
      org_capture_templates = {
        g = {
          description = 'General',
          template = '* %?\n',
        },
        t = {
          description = 'Task',
          template = '* TODO %?\n  %u',
          target = org_path .. "/todos.org"
        },
      },
    })

    -- Keymaps
    local wk = require("which-key")
    local opts = { noremap = true, silent = true }
    wk.register({
      ["<leader>o"] = {
        name = "orgmode",
        a = { "agenda" },
        c = { "caption" },
      },
    }, opts)
  end,
} }
