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
  {
    "gmr458/vscode_modern_theme.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vscode_modern").setup({
        cursorline = true,
        transparent_background = false,
        nvim_tree_darker = true,
      })
    end
  },
  -- { "NLKNguyen/papercolor-theme"},
  -- { "jacoborus/tender.vim" },
  -- { "rebelot/kanagawa.nvim" },
  -- { "rose-pine/neovim", name = "rose-pine"},
  -- { "navarasu/onedark.nvim",
  --   name = "onedark",
  --   config = function()
  --     require("onedark").setup {
  --       style = "darker"
  --     }
  --   end
  -- },

  -- git blame
  { "f-person/git-blame.nvim", name = "gitblame",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = true }
    end,
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR", "WTF" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO", "SEEHERE" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      merge_keywords = true,
      highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF21" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
    -- event = "BufRead",
    -- config = function()
    --   require("todo-comments").setup()
    -- end
  },

  -- discord
  { "vimsence/vimsence" }
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
lvim.colorscheme = "vscode_modern"
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

-- discord ----------------------------------------------------
vim.g.vimsence_small_text = "NeoVim"
vim.g.vimsence_small_image = "neovim"
vim.g.vimsence_editing_details = "Editing: {}"
vim.g.vimsence_editing_state = "Working on: {}"
vim.g.vimsence_file_explorer_text = "In NERDTree"
vim.g.vimsence_file_explorer_details = "Looking for files"
---------------------------------------------------------------
