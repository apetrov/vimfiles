-- Source the existing vimrc if you want to include it
vim.cmd('source ~/.vim/vimrc')

-- Ensure packer.nvim is loaded
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd('packadd packer.nvim')



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
-- Key mappings for Copilot
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', opts)
vim.keymap.set('i', '<C-K>', 'copilot#Cancel()', opts)
--
-- Define options for normal mode key mappings
local noremap_silent_opts = { noremap = true, silent = true }
-- Key mappings for ChatGPT
vim.keymap.set('n', '<leader>cg', ':ChatGPT<CR>', noremap_silent_opts)
vim.keymap.set('n', '<leader>cc', ':lua ClearChatGPTPrompt()<CR>', noremap_silent_opts)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>bb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Configure packer.nvim
return require('packer').startup(function(use)
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
          popup_layout = { },
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

    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

	use({ "kiyoon/jupynium.nvim" })
end)

