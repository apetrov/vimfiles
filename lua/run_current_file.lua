local M = {}

local state = {
  bufnr = nil,
  job_id = nil,
}

local function parent_dir(path)
  local dir = vim.fs.dirname(path)
  if dir == path then
    return nil
  end
  return dir
end

local function nearest_root(path, markers)
  local dir = vim.fs.dirname(path)

  while dir do
    for _, marker in ipairs(markers) do
      if vim.uv.fs_stat(dir .. "/" .. marker) then
        return dir
      end
    end

    dir = parent_dir(dir)
  end
end

local function executable_from_venv(path, executable)
  local root = nearest_root(path, { ".venv" })
  if not root then
    return nil, nil
  end

  local candidate = root .. "/.venv/bin/" .. executable
  if vim.fn.executable(candidate) == 1 then
    return candidate, root
  end
end

local function shell_join(argv)
  return table.concat(vim.tbl_map(vim.fn.shellescape, argv), " ")
end

local function runner_filetype(path)
  local filetype = vim.bo.filetype
  if filetype ~= "" then
    return filetype
  end

  local extension = vim.fn.fnamemodify(path, ":e")
  if extension == "py" then
    return "python"
  end

  if extension == "rb" then
    return "ruby"
  end

  if extension == "st" then
    return "smalltalk"
  end

  if extension == "sh" then
    return "sh"
  end

  if extension == "bash" then
    return "bash"
  end

  if extension == "zsh" then
    return "zsh"
  end

  return filetype
end

local function shell_command_for_current_file(path, filetype, working_dir)
  local first_line = vim.fn.getline(1)

  if filetype == "sh"
    or filetype == "bash"
    or filetype == "zsh"
    or vim.fn.fnamemodify(path, ":e") == "sh"
    or vim.fn.fnamemodify(path, ":e") == "bash"
    or vim.fn.fnamemodify(path, ":e") == "zsh"
    or first_line:match("^#!") then
    if vim.fn.executable("zsh") == 1 then
      return { "zsh", path }, working_dir
    end
  end
end

local function command_for_current_file(path, filetype)
  local working_dir = nearest_root(path, {
    ".git",
    ".python-version",
    ".ruby-version",
    ".tool-versions",
    "pyproject.toml",
    "uv.lock",
    "Gemfile",
  }) or vim.fs.dirname(path)

  if filetype == "python" then
    local venv_python, venv_root = executable_from_venv(path, "python")
    if venv_python then
      return { venv_python, path }, venv_root
    end

    local uv_root = nearest_root(path, { "pyproject.toml", "uv.lock" })
    if uv_root and vim.fn.executable("uv") == 1 then
      return { "uv", "run", "--", "python", path }, uv_root
    end

    if vim.fn.executable("python3") == 1 then
      return { "python3", path }, working_dir
    end

    if vim.fn.executable("python") == 1 then
      return { "python", path }, working_dir
    end
  end

  if filetype == "ruby" then
    if vim.fn.executable("asdf") == 1 then
      return { "asdf", "exec", "ruby", path }, working_dir
    end

    if vim.fn.executable("ruby") == 1 then
      return { "ruby", path }, working_dir
    end
  end

  if filetype == "smalltalk" or filetype == "gst" or vim.fn.fnamemodify(path, ":e") == "st" then
    if vim.fn.executable("gst") == 1 then
      return { "gst", path }, working_dir
    end
  end

  local shell_argv, shell_dir = shell_command_for_current_file(path, filetype, working_dir)
  if shell_argv then
    return shell_argv, shell_dir
  end
end

local function open_runner_window()
  local original_window = vim.api.nvim_get_current_win()

  if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
    local windows = vim.fn.win_findbuf(state.bufnr)
    if #windows > 0 then
      return original_window, windows[1]
    end
  end

  vim.cmd("botright 12split")
  return original_window, vim.api.nvim_get_current_win()
end

function M.run()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Run current file requires a saved file", vim.log.levels.WARN)
    return
  end

  vim.cmd("write")

  local filetype = runner_filetype(path)
  local argv, working_dir = command_for_current_file(path, filetype)
  if not argv then
    vim.notify("No runner configured for filetype: " .. filetype, vim.log.levels.WARN)
    return
  end

  local original_window, runner_window = open_runner_window()
  vim.api.nvim_set_current_win(runner_window)

  if state.job_id then
    pcall(vim.fn.jobstop, state.job_id)
    state.job_id = nil
  end

  if state.bufnr and vim.api.nvim_buf_is_valid(state.bufnr) then
    pcall(vim.api.nvim_buf_delete, state.bufnr, { force = true })
  end

  vim.cmd("enew")
  state.bufnr = vim.api.nvim_get_current_buf()

  state.job_id = vim.fn.termopen(argv, {
    cwd = working_dir,
    on_exit = function()
      state.job_id = nil
    end,
  })

  pcall(vim.api.nvim_buf_set_name, state.bufnr, "Run Current File")

  vim.bo[state.bufnr].buflisted = false
  vim.bo[state.bufnr].bufhidden = "wipe"

  vim.api.nvim_set_current_win(original_window)
  vim.notify("Running: " .. shell_join(argv), vim.log.levels.INFO)
end

function M.command()
  local path = vim.api.nvim_buf_get_name(0)
  local argv = command_for_current_file(path, runner_filetype(path))
  if argv then
    print(shell_join(argv))
  end
end

return M
