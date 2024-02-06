-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  -- GitHub Copilot 
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- css color
  { "brenoprata10/nvim-highlight-colors" },

  -- themes
  { "rebelot/kanagawa.nvim" },
  { "rose-pine/neovim", name = "rose-pine"},
  { "navarasu/onedark.nvim",
    name = "onedark",
    config = function()
      require("onedark").setup {
        style = "darker"
      }
    end
  },

  -- git blame
  { "f-person/git-blame.nvim", name = "gitblame",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = true }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  }
}

-- basic settings ---------------------------------------------
vim.opt.wrap = true

-- hotkeys -----------------------
-- gt or gT to switch buffer
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

-- alt + f to search words in files
lvim.keys.normal_mode["<A-f>"] = ":Telescope live_grep<CR>"

-- ctrl + c to close search highlight
lvim.keys.normal_mode["<C-n>"] = ":noh<CR>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope git_files<CR>"

-- ctrl + t to open terminal
lvim.builtin.terminal.open_mapping = "<c-t>"
-- lvim.builtin.which_key.mappings["e"] = {"<cmd>NvimTreeFocus<CR>", "Explorer"}

---------------------------------------------------------------

-- colorscheme ------------------------------------------------
lvim.colorscheme = "onedark"
---------------------------------------------------------------


-- css color --------------------------------------------------
require("nvim-highlight-colors").setup {}
---------------------------------------------------------------


-- status line ------------------------------------------------
-- local custom_jellybeans = require "lualine.themes.jellybeans"
-- local components = require "lvim.core.lualine.components"

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

lvim.builtin.lualine.sections.lualine_c = { "filename" }
----------------------------------------------------------------


-- Setup GitHub Copilot ---------------------------------------
-- To logout copilot, remove ~/.config/github/hosts.json to delete auth information.
local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end
copilot.setup {
  suggestion = {
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>",
    },
  },
}
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
---------------------------------------------------------------

