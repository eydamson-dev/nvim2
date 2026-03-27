return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode_cmd = "opencode --port"

    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = "right",
        width = 0.4,
        enter = false,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)
        end,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      lsp = {
        enabled = true,
      },
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          local term = require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts)
          if term then
            term:close()
          end
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }

    vim.o.autoread = true

    local keymap = vim.keymap.set

    -- Start/Stop/Toggle
    keymap("n", "<leader>oo", function()
      require("opencode").command("session.new")
    end, { desc = "Start opencode" })

    keymap("n", "<leader>ox", function()
      vim.g.opencode_opts.server.stop()
    end, { desc = "Stop opencode" })

    keymap({ "n", "t" }, "<leader>ot", function()
      vim.g.opencode_opts.server.toggle()
    end, { desc = "Toggle opencode" })

    -- Ask and Select
    keymap({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    keymap({ "n", "x" }, "<leader>os", function()
      require("opencode").select()
    end, { desc = "Select opencode action" })

    -- Agent cycle
    keymap("n", "<leader>oc", function()
      require("opencode").command("agent.cycle")
    end, { desc = "Cycle opencode agent" })

    -- Operator mode (leader-based)
    keymap({ "n", "x" }, "<leader>og", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })

    keymap("n", "<leader>ol", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    -- Scroll (keep as-is)
    keymap("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })

    keymap("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })

    -- Session management
    keymap("n", "<leader>on", function()
      require("opencode").command("session.new")
    end, { desc = "New opencode session" })

    keymap("n", "<leader>op", function()
      require("opencode").command("session.select")
    end, { desc = "Select opencode session" })

    keymap("n", "<leader>oi", function()
      require("opencode").command("session.interrupt")
    end, { desc = "Interrupt opencode" })

    keymap("n", "<leader>oe", function()
      require("opencode").command("session.compact")
    end, { desc = "Compact opencode context" })

    -- Navigation
    keymap("n", "<leader>of", function()
      require("opencode").command("session.first")
    end, { desc = "Go to first message" })

    keymap("n", "<leader>oL", function()
      require("opencode").command("session.last")
    end, { desc = "Go to last message" })

    -- Buffer contexts
    keymap("n", "<leader>ob", function()
      require("opencode").ask("@buffer: ", { submit = true })
    end, { desc = "Ask about current buffer" })

    keymap("n", "<leader>oB", function()
      require("opencode").ask("@buffers: ", { submit = true })
    end, { desc = "Ask about all buffers" })

    -- Model switching via picker
    keymap("n", "<leader>om", function()
      -- Open opencode terminal and send /model command
      local snacks_terminal_opts_local = {
        win = {
          position = "right",
          width = 0.4,
          enter = true,
        },
      }
      require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts_local)
      -- Send the /model command after a short delay to ensure terminal is ready
      vim.defer_fn(function()
        vim.api.nvim_feedkeys("/model", "t", false)
      end, 300)
    end, { desc = "Switch opencode model" })
  end,
}
