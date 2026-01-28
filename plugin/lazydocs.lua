-- LazyDocs - Lazygit-style TUI for browsing DevDocs documentation
-- This file is automatically loaded by Neovim

if vim.g.loaded_lazydocs then
  return
end
vim.g.loaded_lazydocs = true

-- Lazy-load the plugin when commands are used
vim.api.nvim_create_user_command("LazyDocs", function(opts)
  require("lazydocs").setup()
  local query = nil
  if opts.args and opts.args ~= "" then
    query = opts.args
  end
  require("lazydocs").open(query)
end, {
  nargs = "?",
  desc = "Open LazyDocs documentation browser",
})
