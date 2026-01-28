local M = {}

--- Spawn the lazydocs binary in a terminal buffer
---@param buf number Buffer number
---@param binary string Path to lazydocs binary
---@param args? string[] Optional arguments
function M.spawn(buf, binary, args)
  args = args or {}

  -- Build command
  local cmd = { binary }
  vim.list_extend(cmd, args)

  -- Set up environment
  local env = {}

  -- Pass Neovim server address if available
  local servername = vim.v.servername
  if servername and servername ~= "" then
    env.NVIM_LISTEN_ADDRESS = servername
    env.LAZYDOCS_NVIM = "1"
  end

  -- Build env string for termopen
  local env_opts = {}
  for k, v in pairs(env) do
    table.insert(env_opts, k .. "=" .. v)
  end

  -- Spawn terminal
  vim.fn.termopen(cmd, {
    env = env,
    on_exit = function(_, exit_code, _)
      -- Close the window when the process exits
      if exit_code == 0 then
        local wins = vim.fn.win_findbuf(buf)
        for _, win in ipairs(wins) do
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end
      end
    end,
  })

  -- Enter insert mode for terminal interaction
  vim.cmd("startinsert")
end

return M
