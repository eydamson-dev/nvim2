return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    styles = {
      zen = {
        backdrop = { transparent = false },
      }
    },
    zen = {
      center = true,
      win = {
        width = 0.6,
        height = 0,
      },
      show = {
        statusline = true,
        tabline = true,
      },
      toggles = {
        dim = false,
        git_signs = true,
        diagnostics = true,
        inlay_hint = true
      }
    },
    explorer = {
      enabled = true,
      picker = {
        sources = {
          explorer = {
            -- Customize the layout for centering the floating window
            layout = {
              layout = {
                position = "center", -- Center the window horizontally and vertically
                size = {
                  width = 0.5,       -- Set width to 50% of screen width
                  height = 0.8,      -- Set height to 80% of screen height
                },
              },
            },
            -- This is the crucial setting for auto-closing.
            -- It redefines the action when you press <CR> (Enter) on a file.
            -- "open" opens the file in the current window.
            -- "close" closes the picker/explorer window.
            -- Combining them achieves "open file and auto close explorer".
            action_select = { "open", "close" },
          },
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        pick = "telescope.nvim",
        keys = {
          { icon = " ", key = "<space>", desc = "Projects", action = ":NeovimProjectDiscover" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          {
            icon = "󰒲 ",
            key = "L",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
    },
    sections = {
      { section = "keys",   gap = 1, padding = 1 },
      { section = "startup" },
      { section = "header" },
    },
  },
  init = function()
    vim.opt.laststatus = 3 -- This makes lualine span the entire width of the terminal
    local keymap = vim.keymap.set
    keymap("n", "<leader>z", function()
      Snacks.zen()
    end)
  end
}
