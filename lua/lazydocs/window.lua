local M = {}

--- Create a floating window
---@param opts LazyDocsWindowConfig
---@return number buf Buffer number
---@return number win Window number
function M.create_floating(opts)
  opts = opts or {}
  local width_ratio = opts.width_ratio or 0.9
  local height_ratio = opts.height_ratio or 0.9
  local border = opts.border or "rounded"

  -- Calculate dimensions
  local width = math.floor(vim.o.columns * width_ratio)
  local height = math.floor(vim.o.lines * height_ratio)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  -- Window options
  local win_opts = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = border,
    title = " LazyDocs ",
    title_pos = "center",
  }

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  -- Set window options
  vim.api.nvim_set_option_value("winhl", "Normal:Normal,FloatBorder:FloatBorder", { win = win })

  -- Auto-close window when focus is lost
  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = buf,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Allow 'q' to close window in normal mode (after scrolling exits terminal mode)
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, { buffer = buf, silent = true })

  -- Disable mouse scrolling to prevent accidentally exiting terminal mode
  local scroll_keys = { "<ScrollWheelUp>", "<ScrollWheelDown>", "<ScrollWheelLeft>", "<ScrollWheelRight>" }
  for _, key in ipairs(scroll_keys) do
    vim.keymap.set({ "n", "t" }, key, "<Nop>", { buffer = buf, silent = true })
  end

  return buf, win
end

return M
