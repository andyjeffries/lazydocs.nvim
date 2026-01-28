# lazydocs.nvim

Neovim plugin for [LazyDocs](https://github.com/andyjeffries/lazydocs) - a Lazygit-style TUI for browsing DevDocs documentation.

## Requirements

- Neovim 0.9+
- [lazydocs](https://github.com/andyjeffries/lazydocs) binary installed

## Installation

### lazy.nvim

```lua
{
  "lazydocs/lazydocs.nvim",
  dependencies = {},
  keys = {
    { "<leader>ld", "<cmd>LazyDocs<cr>", desc = "LazyDocs" },
  },
  cmd = { "LazyDocs", "LazyDocsLookup" },
  opts = {},
}
```

### packer.nvim

```lua
use {
  "lazydocs/lazydocs.nvim",
  config = function()
    require("lazydocs").setup()
  end,
}
```

## Configuration

```lua
require("lazydocs").setup({
  -- Path to lazydocs binary (auto-detected if nil)
  binary_path = nil,

  -- Floating window configuration
  floating_window = {
    width_ratio = 0.9,   -- 90% of screen width
    height_ratio = 0.9,  -- 90% of screen height
    border = "rounded",  -- Border style
  },

  -- Keymaps (set to nil to disable)
  keymaps = {
    open = "<leader>ld",  -- Open LazyDocs
    lookup = nil,         -- Lookup word under cursor (K)
  },
})
```

## Commands

| Command | Description |
|---------|-------------|
| `:LazyDocs` | Open LazyDocs |
| `:LazyDocs <query>` | Open and search for query |
| `:LazyDocsLookup` | Look up word under cursor |

## LazyVim Integration

Add to your LazyVim extras or plugins:

```lua
-- lua/plugins/lazydocs.lua
return {
  "lazydocs/lazydocs.nvim",
  keys = {
    { "<leader>ld", "<cmd>LazyDocs<cr>", desc = "LazyDocs" },
    { "K", "<cmd>LazyDocsLookup<cr>", desc = "LazyDocs Lookup", ft = { "javascript", "typescript", "python", "go", "ruby" } },
  },
  cmd = { "LazyDocs" },
  opts = {},
}
```

## Installing Documentation

LazyDocs manages documentation from within the TUI:

1. Open LazyDocs with `:LazyDocs` or `<leader>ld`
2. Press `a` to add documentation
3. Search and select a docset
4. Press `Enter` to install

Or use the CLI:

```bash
lazydocs install javascript
lazydocs install python~3.12
lazydocs install go
```

## License

MIT
