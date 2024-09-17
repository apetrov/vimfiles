-- TODO
-- Move vim bundles to nvim lazy
-- Source the existing vimrc if you want to include it
vim.cmd('source ~/.vim/vimrc')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Function to clear the ChatGPT input prompt
function ClearChatGPTPrompt()
  local bufnr = vim.fn.bufnr('%')
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if #lines > 0 then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {""})
  end
end


-- Define common options for key mappings
local opts = { silent = true, expr = true }
local noremap_silent_opts = { noremap = true, silent = true }


vim.g.mapleader = ' '

require('lazy').setup({
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup({
        popup_layout = {},
        openai_params = {
          model = "gpt-4o",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 1000,
          temperature = 0,
          top_p = 1,
          n = 1,
        }
      })

      vim.keymap.set('n', '<leader>cg', ':ChatGPT<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<leader>cc', ':lua ClearChatGPTPrompt()<CR>', noremap_silent_opts)

    end
  },

  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set('n', '<Leader>gp', ':Git pull --rebase<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gf', ':Git fetch<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gP', ':Git push<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gs', ':Git<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gB', ':Gblame<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gl', ':Glog<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gL', ':Glog %<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gr', ':Gread<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gw', ':Gwrite<CR>', norermap_silent_opts)
    end
  },

  {
    "kiyoon/jupynium.nvim"
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>fa', ':Neotree toggle<CR>', { noremap = true, silent = true })
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true, silent = true })
    end
  },


  { 'tmhedberg/matchit'},
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb'},
  { 'tpope/vim-dispatch'},
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround'},
  { 'tpope/vim-commentary'},
  { 'junegunn/fzf.vim'},
  { 'mileszs/ack.vim', cmd = 'Ack' },
  { 'tpope/vim-projectionist' },
  { 'vim-ruby/vim-ruby' },
  { 'tpope/vim-rake' },
  { 'tpope/vim-bundler' },
  { 'thoughtbot/vim-rspec' },
  { 'tpope/vim-rails' },
  { 'tpope/vim-haml' },

  { 'tpope/vim-endwise' },
  { 'tpope/vim-unimpaired' },
  { 'roman/golden-ratio' },
  { 'rizzatti/funcoo.vim' },
  { 'jgdavey/tslime.vim' },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" } },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" } },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" } },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" } },
      { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "t" } },
    },
  },

  { 'jnurmine/Zenburn' },
  { 'nanotech/jellybeans.vim' },
  { 'liuchengxu/space-vim-theme',
    config = function()
      -- vim.cmd('colorscheme space_vim_theme')
    end
  },
  { 'plasticboy/vim-markdown' },
  { 'ntpeters/vim-better-whitespace' },
  { 'danro/rename.vim' },
  -- { 'prabirshrestha/vim-lsp' },
  -- { 'mattn/vim-lsp-settings' },
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', opts)
      vim.keymap.set('i', '<C-K>', 'copilot#Cancel()', opts)
    end
  },
  {
    "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config= function()
      vim.cmd.colorscheme "catppuccin-macchiato"
    end

  },

  -- LSP
  { 'williamboman/mason.nvim',
    config=function()
      require('mason').setup({
      })
    end
  },

  { "williamboman/mason-lspconfig.nvim", 
    config=function()
      require('mason-lspconfig').setup({
        ensure_installed = { "pylsp", "ruby_lsp"}
      })
    end
  },
  { "neovim/nvim-lspconfig",
    config=function()
      require('lspconfig').pylsp.setup{
        settings = {
          pylsp = {
            plugins = {
              -- skip all this noise
              pylint = {enabled = false},        -- Disable pylint
              pyflakes = {enabled = false},      -- Disable pyflakes
              pycodestyle = {enabled = false},   -- Disable pycodestyle
              flake8 = {enabled = false},        -- Disable flake8
              mccabe = {enabled = false},        -- Disable mccabe
              pydocstyle = {enabled = false},    -- Disable pydocstyle
              mypy = {enabled = false},          -- Disable mypy
              yapf = {enabled = false},          -- Disable yapf
              autopep8 = {enabled = false},      -- Disable autopep8
              rope_autoimport = {enabled = false},-- Disable rope autoimport
            },
          },
        }
      }

      vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>gg', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, opts)
    end
  },


  { 'jgdavey/vim-blockle' },
  {
    'nelstrom/vim-textobj-rubyblock',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'kana/vim-textobj-entire',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'kana/vim-textobj-indent',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'kana/vim-textobj-syntax',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'whatyouhide/vim-textobj-erb',
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'bps/vim-textobj-python',
    dependencies = { 'kana/vim-textobj-user' }
  },


  {
	  "folke/which-key.nvim",
	  event = "VeryLazy",
	  opts = {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  -- refer to the configuration section below
	  },
	  keys = {
		  {
			  "<leader>?",
			  function()
				  require("which-key").show({ global = false })
			  end,
			  desc = "Buffer Local Keymaps (which-key)",
		  },
	  },
  },


  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      -- provider = "copilot", -- Recommend using Claude
      provider = "openai", -- Recommend using Claude
      openai = {
        endpoint="https://api.openai.com/v1",
        model = "gpt-4o",
        api_key_name = "OPENAI_API_KEY",
        temperature = 0,
        max_tokens = 4096,
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = true },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): any
        list_opener = "copen",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

})


vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.autowrite = true
vim.opt.shell = "/bin/bash"  -- Use bash instead of zsh to avoid issues

vim.opt.hlsearch = true  -- Highlight search terms
vim.opt.incsearch = true  -- Show search matches as you type

-- Avoid Vim backup files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.history = 1000
vim.opt.showcmd = true
vim.opt.visualbell = true
vim.opt.errorbells = false

-- Make things faster
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100
vim.opt.splitright = true
vim.opt.winwidth = 84

-- Works for both OSX and linux
vim.opt.clipboard = "unnamed"
-- not working from here


-- Disable cursor line highlighting
vim.opt.cursorline = false

-- Disable cursor column highlighting
vim.opt.cursorcolumn = false

-- Enable lazy redraw
vim.opt.lazyredraw = true

-- Set the number of lines to scroll when the cursor moves off the screen
vim.opt.scrolljump = 8

-- Enable the enhanced command-line completion mode
vim.opt.wildmenu = true


-- Visual mode key mapping: repeat last command with '.'
vim.api.nvim_set_keymap('v', '.', ':norm.<CR>', opts)


vim.api.nvim_set_keymap('n', '<leader>tt', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tp', ':tabprevious<CR>', { noremap = true, silent = true })
