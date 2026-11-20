local api = vim.api

vim.cmd("filetype plugin indent on")
vim.opt.runtimepath:append(vim.fn.expand("~/.fzf"))
vim.opt.wildignore = {
  "*.swp", "*.bak", "*.pyc", "*.class",
  "*.o", "*.out", "*.obj", ".git", "*.rbc", ".svn", "*.gem",
  "*.zip", "*.tar.gz", "*.tar.bz2", "*.rar", "*.tar.xz",
  "vendor/gems/*", "vendor/cache/*", ".bundle/*", ".sass-cache/*", ".git/*", "cookbooks/*",
  "log/*", "target/*", ".DS_Store/*", "bin/*", "*~", "._*",
}

vim.filetype.add({
  filename = {
    Gemfile = "ruby",
    ["Gemfile.lock"] = "ruby",
    Rakefile = "ruby",
    Capfile = "ruby",
    ["config.ru"] = "ruby",
    config = "ruby",
    Guardfile = "ruby",
  },
})

local group = api.nvim_create_augroup("UserEditor", { clear = true })

api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "make",
  callback = function(event)
    vim.bo[event.buf].expandtab = false
    vim.bo[event.buf].shiftwidth = 4
    vim.bo[event.buf].softtabstop = 0
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.rb", "*_spec.py" },
  callback = function(event)
    vim.bo[event.buf].makeprg = event.match:sub(-3) == ".rb" and "ruby %" or "mamba %"
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group,
  pattern = { "*.htm", "*.html", "*.erb" },
  callback = function(event)
    vim.bo[event.buf].tabstop = 2
    vim.bo[event.buf].shiftwidth = 2
    vim.bo[event.buf].softtabstop = 2
  end,
})

api.nvim_create_autocmd("WinEnter", {
  group = group,
  callback = function()
    vim.wo.number = true
    vim.wo.winfixheight = true
    vim.cmd.wincmd("=")
  end,
})

api.nvim_create_autocmd("WinLeave", {
  group = group,
  callback = function()
    vim.wo.number = false
  end,
})

api.nvim_create_user_command("Path", function()
  print(table.concat(vim.opt.path:get(), "\n"))
end, {})

api.nvim_create_user_command("ExtractMethod", function()
  local macro = '^"zdt=x"xDddmv[mOdef <C-r>z<CR><C-r>x<Esc>jo<Esc>\'v'
  vim.fn.setreg("a", vim.keycode(macro), "c")
  vim.cmd.normal("@a")
end, {})

api.nvim_create_user_command("GChanges", function()
  local files = vim.fn.systemlist({ "git", "files" })
  if vim.v.shell_error ~= 0 then
    vim.notify(table.concat(files, "\n"), vim.log.levels.ERROR)
    return
  end
  vim.fn.setqflist(vim.tbl_map(function(file)
    return { filename = file, lnum = 1 }
  end, files))
  vim.cmd.copen()
end, { bar = true, desc = "Open files reported by git files in quickfix" })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

for lhs, rhs in pairs({
  ["<Left>"] = ":bp!<CR>",
  ["<Right>"] = ":bn!<CR>",
  ["<Up>"] = ":cpfile!<CR>",
  ["<Down>"] = ":cnfile!<CR>",
}) do
  vim.keymap.set("n", lhs, rhs, { remap = true })
end

for lhs, rhs in pairs({
  Y = "y$",
  ["<leader>mem"] = ":ExtractMethod<CR>",
  ["<leader>bd"] = ":bd<CR>",
  ["<leader>bN"] = ":vnew<CR>",
  ["<leader>bn"] = ":bn!<CR>",
  ["<leader>bp"] = ":bp!<CR>",
  ["<leader>bY"] = "ggyG",
  ["<leader>bq"] = ":wq<CR>",
  ["<leader>fs"] = ":w<CR>",
  ["<leader>do"] = ":windo diffthis<CR>",
  ["<leader>dO"] = ":windo diffoff<CR>",
  ["<leader>1"] = "<C-w>H",
  ["<leader>2"] = "<C-w>L",
  ["<leader>xs"] = ":JupyniumStartSync<CR>",
}) do
  vim.keymap.set({ "n", "x", "s", "o" }, lhs, rhs, { remap = true })
end

for lhs, runner in pairs({
  ["<leader>mtf"] = "RunCurrentSpecFile",
  ["<leader>mts"] = "RunNearestSpec",
  ["<leader>mtl"] = "RunLastSpec",
}) do
  vim.keymap.set({ "n", "x", "s", "o" }, lhs, function()
    vim.fn[runner]()
  end)
end

vim.keymap.set("n", "<leader>bS", function()
  vim.fn.Send_to_Tmux(vim.fn.getline(".") .. "\n")
end)

vim.keymap.set("x", "<leader>bS", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), {
    type = vim.fn.mode(),
    exclusive = vim.o.selection == "exclusive",
  })
  for _, line in ipairs(lines) do
    vim.fn.Send_to_Tmux(line .. "\n")
  end
  vim.cmd.normal({ vim.keycode("<Esc>"), bang = true })
end)
