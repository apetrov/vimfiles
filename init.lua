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
      vim.keymap.set('n', '<Leader>gl', ':Glog<CR>', nonremap_silent_opts)
      vim.keymap.set('n', '<Leader>gL', ':Glog %<CR>', noremap_silent_opts)
      vim.keymap.set('n', '<Leader>gr', ':Gread<CR>', nonremap_silent_opts)
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
    }
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
  }
})

-- Key mappings for Copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', opts)
vim.keymap.set('i', '<C-K>', 'copilot#Cancel()', opts)
