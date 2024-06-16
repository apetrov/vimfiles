-- Source the existing vimrc if you want to include it
vim.cmd('source ~/.vim/vimrc')

-- Ensure packer.nvim is loaded
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
vim.cmd('packadd packer.nvim')

vim.api.nvim_set_keymap('n', '<leader>cg', ':ChatGPT<CR>', { noremap = true, silent = true })


-- Function to clear the ChatGPT input prompt
function ClearChatGPTPrompt()
  local bufnr = vim.fn.bufnr('%')
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if #lines > 0 then
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {""})
  end
end

-- Map <leader>cc to clear the ChatGPT prompt
vim.api.nvim_set_keymap('n', '<leader>cc', ':lua ClearChatGPTPrompt()<CR>', { noremap = true, silent = true })


-- Configure packer.nvim
return require('packer').startup(function(use)
  use({
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
          popup_layout = {
            submit = "<C-g>"
          },
        })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })
  -- Add more plugins here if needed
end)




