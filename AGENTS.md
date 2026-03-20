# Neovim Configuration - Agent Guidelines

## Project Overview
- **Type**: Neovim configuration (`~/.config/nvim`)
- **Plugin Manager**: lazy.nvim
- **Leader Key**: `,` (comma)
- **Plugins**: ~40 plugins

## Setup
1. Clone to `~/.config/nvim`
2. Open Neovim - lazy.nvim auto-bootstraps
3. Run `:Lazy sync` to install plugins

## Directory Structure
```
nvim/
├── init.lua                  -- Entry point
├── lazy-lock.json            -- Locked plugin versions
├── .stylua.toml              -- Lua formatter config
├── .pre-commit-config.yaml   -- Pre-commit hooks
├── lua/
│   ├── config/lazy.lua       -- Plugin manager setup
│   ├── plugins/*.lua         -- Individual plugin configs (~35 files)
│   └── user/
│       ├── options.lua       -- vim.opt settings
│       └── keymaps.lua       -- Keybindings
```

## Commands

### Plugin Management
```bash
nvim +":Lazy sync" +qa        # Install/update plugins
nvim +":Lazy clean" +qa      # Remove unused plugins
nvim +":Lazy update" +qa     # Check for updates
nvim +":Lazy" +qa            # Open lazy.nvim UI
```

### Linting & Formatting
```bash
stylua --check .             # Check formatting
stylua .                     # Fix formatting
nvim --headless +qa          # Basic load test
pre-commit run --all-files   # Full validation
```

### Health Check
```bash
nvim --headless +qa          # Load test
nvim +":checkhealth" +qa    # Full diagnostics
```

## Git Workflow
- **Branches**: Always create `feat/<description>`, `fix/<description>`, or `chore/<description>` from `master`
- **Commits**: NEVER commit automatically - only when user requests
- **Push/PR**: NEVER push unless explicitly requested
- **PR Creation**: When user requests a PR, ALWAYS create the PR link in this format:
  ```
  https://github.com/eydamson-dev/nvim2/pull/new/<branch-name>
  ```
  The user will create the PR manually on GitHub.

## Code Style

### Formatting (Stylua)
- 120 column width, 2-space indentation, Unix line endings
- Double quotes preferred, always use call parentheses
- Sort requires enabled

### Keymaps
Use `vim.keymap.set()` instead of `vim.api.nvim_set_keymap`:
```lua
vim.keymap.set("n", "ss", ":w<CR>", { noremap = true, silent = true })
```

### Options
Use `vim.opt` instead of `vim.cmd`:
```lua
vim.opt.whichwrap:append { '<', '>', '[', ']', 'h', 'l' }
```

### Autocommands
Use `vim.api.nvim_create_autocmd`:
```lua
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    set_foldmethod()
  end,
})
```

### Plugin Config
Use `opts` table for simple configs; `config` function only when needed:
```lua
-- Simple: return { "plugin/name", opts = { key = "value" } }
-- Complex: return { "plugin/name", config = function() ... end }
```

### Imports
Use consistent require paths (no .lua extension):
```lua
require "user.options"
require "plugins.lsp"
```

### Naming Conventions
- **Files**: lowercase with hyphens (`nvim-tree.lua`)
- **Variables/Functions**: snake_case
- **Tables/Modules**: PascalCase for public modules (`local M = {}`)
- **Private functions**: prefix with underscore

### Error Handling
Use pcall for unsafe operations:
```lua
local ok, result = pcall(require, "module")
if not ok then
  vim.notify("Failed to load: " .. result, vim.log.levels.ERROR)
  return
end
```

### Lazy Loading
```lua
return { "plugin/name", event = "BufReadPre" }
return { "plugin/name", cmd = "Git" }
return { "plugin/name", keys = { { "n", "<leader>ff", ... } } }
```

## Common Tasks

### Add Plugin
1. Create `lua/plugins/<name>.lua`
2. Return plugin spec table
3. Run `:Lazy sync`

### Add Keybinding
Edit `lua/user/keymaps.lua` - use `vim.keymap.set()`

### Configure LSP
Edit `lua/plugins/lsp.lua` - add server to `ensure_installed` list

## Health Check
```bash
nvim --headless +qa           # Load test
nvim +":checkhealth" +qa     # Full diagnostics
```
