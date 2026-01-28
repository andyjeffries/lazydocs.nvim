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

  return buf, win
end

return M
