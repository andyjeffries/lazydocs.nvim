local M = {}

--- Setup Vim commands
function M.setup()
  vim.api.nvim_create_user_command("LazyDocs", function(opts)
    local query = nil
    if opts.args and opts.args ~= "" then
      query = opts.args
    end
    require("lazydocs").open(query)
  end, {
    nargs = "?",
    desc = "Open LazyDocs documentation browser",
  })

  vim.api.nvim_create_user_command("LazyDocsLookup", function()
    require("lazydocs").lookup()
  end, {
    desc = "Look up symbol under cursor in LazyDocs",
  })
end

return M
