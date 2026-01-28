local M = {}

local config = require("lazydocs.config")
local window = require("lazydocs.window")
local terminal = require("lazydocs.terminal")

---@class LazyDocsConfig
---@field binary_path? string Path to lazydocs binary (auto-detected if nil)
---@field floating_window? LazyDocsWindowConfig Floating window configuration
---@field keymaps? LazyDocsKeymaps Keymap configuration

---@class LazyDocsWindowConfig
---@field width_ratio? number Width ratio (0.0-1.0), default 0.9
---@field height_ratio? number Height ratio (0.0-1.0), default 0.9
---@field border? string Border style, default "rounded"

---@class LazyDocsKeymaps
---@field open? string Keymap to open LazyDocs, default "<leader>ld"
---@field lookup? string Keymap to lookup symbol under cursor, default "K"

--- Setup LazyDocs with optional configuration
---@param opts? LazyDocsConfig
function M.setup(opts)
  config.setup(opts)

  -- Register commands
  require("lazydocs.commands").setup()
end

--- Open LazyDocs TUI
---@param query? string Optional initial search query
function M.open(query)
  local binary = config.find_binary()
  if not binary then
    vim.notify("LazyDocs binary not found. Please install it or set binary_path.", vim.log.levels.ERROR)
    return
  end

  local win_config = config.get().floating_window
  local buf, win = window.create_floating(win_config)

  terminal.spawn(buf, binary, query and { "--lookup", query } or {})
end

--- Lookup the symbol under cursor
function M.lookup()
  local word = vim.fn.expand("<cword>")
  if word == "" then
    vim.notify("No word under cursor", vim.log.levels.WARN)
    return
  end

  M.open(word)
end

return M
