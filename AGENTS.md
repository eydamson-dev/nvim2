# Neovim Configuration

## Project Overview

- **Type**: Neovim configuration (`~/.config/nvim`)
- **Plugin Manager**: lazy.nvim
- **Leader Key**: `,` (comma)
- **Plugins**: ~40 plugins

## Setup

1. Clone this repo to `~/.config/nvim`
2. Open Neovim - lazy.nvim will auto-bootstrap and install plugins
3. Run `:Lazy sync` to ensure all plugins are installed

## Directory Structure

```
nvim/
├── init.lua                  -- Entry point
├── lazy-lock.json            -- Locked plugin versions
├── .stylua.toml              -- Lua formatter config
├── .pre-commit-config.yaml   -- Pre-commit hooks
├── lua/
│   ├── config/
│   │   └── lazy.lua         -- Plugin manager setup
│   ├── plugins/             -- Individual plugin configs
│   │   ├── lsp.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   └── ...
│   └── user/
│       ├── options.lua      -- vim.opt settings
│       └── keymaps.lua      -- Keybindings
```

## Plugin Management

Uses **lazy.nvim** with spec import pattern.

### Commands

- `:Lazy` - Open lazy.nvim UI
- `:Lazy sync` - Install/update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy update` - Check for updates

## Git Workflow

### Branch Creation

- **ALWAYS create a new branch** for each coding session
- Branch naming: `feat/<description>`, `fix/<description>`, or `chore/<description>`
- Branch from: `master`

### Commits

- **NEVER commit automatically** - only commit when user explicitly requests it
- **NEVER amend commits** unless explicitly requested

### Push & PR

- **NEVER push** unless explicitly requested
- After user approves changes, create PR via `gh pr create`
- Use community standard PR template
- Return PR URL to user after creation

## Code Style

Use modern Neovim 0.10+ standards:

### Keymaps

Use `vim.keymap.set()` instead of `vim.api.nvim_set_keymap`:

```lua
-- Bad
vim.api.nvim_set_keymap("n", "ss", ":w<CR>", { noremap = true, silent = true })

-- Good
vim.keymap.set("n", "ss", ":w<CR>", { noremap = true, silent = true })
```

### Options

Use `vim.opt` instead of `vim.cmd`:

```lua
-- Bad
vim.cmd "set whichwrap+=<,>,[,],h,l"

-- Good
vim.opt.whichwrap:append { '<', '>', '[', ']', 'h', 'l' }
```

### Autocommands

Use `vim.api.nvim_create_autocmd`:

```lua
-- Bad
vim.cmd("autocmd BufReadPre * lua set_foldmethod()")

-- Good
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function()
    set_foldmethod()
  end,
})
```

### Plugin Config

Use `opts` table when plugin supports it:

```lua
-- For simple configs
return {
  "plugin/name",
  opts = { key = "value" },
}

-- Only use config function when needed
return {
  "plugin/name",
  config = function()
    -- complex setup
  end,
}
```

## Linting & Formatting

### Tools

- **Stylua** - Lua formatter (standard in Neovim community)
- **pre-commit** - Hook framework

### Validation Commands

```bash
# Check formatting
stylua --check .

# Fix formatting
stylua .

# Full validation
pre-commit run --all-files

# Basic load test
nvim --headless +qa
```

### Pre-commit Hooks

The project uses pre-commit. Install with:

```bash
pip install pre-commit
pre-commit install
```

## Common Tasks

### Add a New Plugin

1. Create new file in `lua/plugins/<name>.lua`
2. Return plugin spec table
3. Run `:Lazy sync` to install

### Configure LSP Server

Edit `lua/plugins/lsp.lua`:
- Add server to `ensure_installed` list in Mason config
- Add custom config in `lsp.config()` section

### Add Keybinding

Edit `lua/user/keymaps.lua`:
- Use `vim.keymap.set()`
- Follow the existing patterns

## Health Check

Run these to verify config:

```bash
nvim --headless +qa           # Basic load test
nvim +":checkhealth" +qa      # Full diagnostics
```
