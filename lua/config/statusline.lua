local M = {}

function M.indentation_warning()
  local buffer = vim.b
  if buffer.statusline_indentation_warning == nil then
    local tabs = vim.fn.search([[^\t]], "nw") ~= 0
    local spaces = vim.fn.search("^ ", "nw") ~= 0
    local warning = ""
    if tabs and spaces then
      warning = "[mixed-indenting]"
    elseif (spaces and not vim.bo.expandtab) or (tabs and vim.bo.expandtab) then
      warning = "[&et]"
    end
    buffer.statusline_indentation_warning = warning
  end
  return buffer.statusline_indentation_warning
end

function M.trailing_space_warning()
  local buffer = vim.b
  if buffer.statusline_trailing_space_warning == nil then
    buffer.statusline_trailing_space_warning = vim.fn.search([[\s\+$]], "nw") ~= 0 and [=[[\s]]=] or ""
  end
  return buffer.statusline_trailing_space_warning
end

function M.current_highlight()
  local name = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
  return name ~= "" and "[" .. name .. "]" or ""
end

vim.api.nvim_create_autocmd({ "CursorHold", "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("UserStatusline", { clear = true }),
  callback = function(event)
    vim.b[event.buf].statusline_indentation_warning = nil
    vim.b[event.buf].statusline_trailing_space_warning = nil
  end,
})

vim.opt.laststatus = 2
vim.opt.statusline = table.concat({
  "%f",
  "%#WarningMsg#%{&ff!='unix'?'['.&ff.']':''}%*",
  "%#WarningMsg#%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}%*",
  "%h%y%r%m",
  "%#Error#%{v:lua.require'config.statusline'.indentation_warning()}%*",
  "%{v:lua.require'config.statusline'.trailing_space_warning()}",
  "%#Error#%{&paste?'[paste]':''}%*",
  "%{fugitive#statusline()}",
  "%=%{v:lua.require'config.statusline'.current_highlight()}%c,%l/%L %P",
})

return M
