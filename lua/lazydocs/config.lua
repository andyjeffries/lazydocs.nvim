local M = {}

---@type LazyDocsConfig
local defaults = {
  binary_path = nil,
  floating_window = {
    width_ratio = 0.9,
    height_ratio = 0.9,
    border = "rounded",
  },
  keymaps = {
    open = "<leader>ld",
    lookup = nil, -- Don't override K by default
  },
}

---@type LazyDocsConfig
local config = {}

--- Setup configuration
---@param opts? LazyDocsConfig
function M.setup(opts)
  config = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  -- Set up keymaps if configured
  if config.keymaps.open then
    vim.keymap.set("n", config.keymaps.open, function()
      require("lazydocs").open()
    end, { desc = "Open LazyDocs" })
  end

  if config.keymaps.lookup then
    vim.keymap.set("n", config.keymaps.lookup, function()
      require("lazydocs").lookup()
    end, { desc = "LazyDocs lookup" })
  end
end

--- Get the current configuration
---@return LazyDocsConfig
function M.get()
  return config
end

--- Find the lazydocs binary
---@return string|nil
function M.find_binary()
  -- Check configured path first
  if config.binary_path then
    if vim.fn.executable(config.binary_path) == 1 then
      return config.binary_path
    end
    return nil
  end

  -- Check common locations
  local paths = {
    "lazydocs", -- In PATH
    vim.fn.expand("~/.local/bin/lazydocs"),
    vim.fn.expand("~/go/bin/lazydocs"),
    "/usr/local/bin/lazydocs",
  }

  for _, path in ipairs(paths) do
    if vim.fn.executable(path) == 1 then
      return path
    end
  end

  return nil
end

return M
