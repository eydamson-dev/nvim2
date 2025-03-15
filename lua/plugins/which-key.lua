return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- Ensure `which-key` is installed and loaded
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    -- Plugin setup with updated options
    local setup = {
      preset = "modern",
      triggers = {
        { "<auto>",   mode = "nixsotc" },
        { "<leader>", mode = { "n", "v" } },
      },
      plugins = {
        marks = true,   -- Shows a list of your marks on ' and `
        registers = true, -- Shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- Show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- Number of spelling suggestions to show
        },
        presets = {
          operators = false, -- Adds help for operators like d, y, ...
          motions = false,  -- Adds help for motions
          text_objects = false, -- Help for text objects after entering an operator
          windows = true,   -- Default bindings on <c-w>
          nav = true,       -- Misc bindings to work with windows
          z = false,        -- Bindings for folds, spelling, etc., prefixed with z
          g = false,        -- Bindings prefixed with g
        },
      },
      -- legacy key_labels = {
      --   -- Optional: Override labels for special keys for improved readability
      --   ["<space>"] = "SPC",
      --   ["<cr>"] = "RET",
      --   ["<tab>"] = "TAB",
      -- },
      icons = {
        breadcrumb = "»", -- Symbol for active key combo in the command line
        separator = "➜", -- Symbol between a key and its label
        group = "+", -- Symbol prepended to a group
      },
      keys = {
        scroll_down = "<c-d>", -- Scroll down inside the popup
        scroll_up = "<c-u>", -- Scroll up inside the popup
      },
      win = {
        border = "rounded", -- Window border style
        -- position = "bottom", -- Window position
        -- padding = { 2, 2 },  -- Extra window padding
        -- height = { min = 4, max = 25 }, -- Min and max height of columns
        -- width = { min = 20, max = 50 }, -- Min and max width of columns
        -- height = { min = 4, max = 25 },
        col = 0.5,
        row = 0.5,
        wo = {
          winblend = 5
        }
      },
      layout = {
        height = { min = 4, max = 25 }, -- Min and max height of columns
        width = { min = 20, max = 50 }, -- Min and max width of columns
        spacing = 3,                -- Spacing between columns
        align = "left",             -- Align columns
      },
      -- legacy ignore_missing = true,                -- Hide mappings without labels
      -- legacy hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- Hide mapping boilerplate
      show_help = true, -- Show help message on command line when popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
    }

    -- General options for mappings
    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings
      silent = true, -- Use `silent` when creating keymaps
      noremap = true, -- Use `noremap` when creating keymaps
      nowait = true, -- Use `nowait` when creating keymaps
    }

    -- Define your mappings
    local mappings = {
      { "<leader>a",  "<cmd>Alpha<cr>",                                                                                                 desc = "Alpha",            mode = "n" },
      { "<leader>b",  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers",          mode = "n" },
      { "<leader>w",  "<cmd>w!<CR>",                                                                                                    desc = "Save",             mode = "n" },
      { "<leader>q",  "<cmd>q!<CR>",                                                                                                    desc = "Quit",             mode = "n" },
      { "<leader>c",  "<cmd>Bdelete!<CR>",                                                                                              desc = "Close Buffer",     mode = "n" },
      { "<leader>h",  "<cmd>nohlsearch<CR>",                                                                                            desc = "No Highlight",     mode = "n" },
      { "<leader>i",  "<cmd>JSImport<CR>",                                                                                              desc = "JSImport",         mode = "n" },
      { "<leader>f",  group = "file" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                                                                                  desc = "Find files",       mode = "n" },
      { "<leader>F",  "<cmd>Telescope live_grep<cr>",                                                                                   desc = "Find Text",        mode = "n" },
      { "<leader>P",  "<cmd>Telescope projects<cr>",                                                                                    desc = "Projects",         mode = "n" },
      { "<leader>z",  "<cmd>ZenMode<CR>",                                                                                               desc = "Zen mode",         mode = "n" },

      -- Lazy group
      { "<leader>p",  group = "Lazy" },
      { "<leader>pc", "<cmd>Lazy clean<cr>",                                                                                            desc = "Clean" },
      { "<leader>pi", "<cmd>Lazy install<cr>",                                                                                          desc = "Install" },
      { "<leader>ps", "<cmd>Lazy sync<cr>",                                                                                             desc = "Sync" },

      -- Git group
      { "<leader>g",  group = "Git" },
      { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>",                                                                                 desc = "Lazygit" },
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",                                                                    desc = "Next Hunk" },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",                                                                    desc = "Prev Hunk" },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",                                                                   desc = "Blame" },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",                                                                 desc = "Preview Hunk" },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",                                                                   desc = "Reset Hunk" },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",                                                                 desc = "Reset Buffer" },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",                                                                   desc = "Stage Hunk" },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",                                                              desc = "Undo Stage Hunk" },
      { "<leader>go", "<cmd>Telescope git_status<cr>",                                                                                  desc = "Open changed file" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>",                                                                                desc = "Checkout branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",                                                                                 desc = "Checkout commit" },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                                                                                desc = "Diff" },

      -- Search group
      { "<leader>s",  group = "Search" },
      { "<leader>sb", "<cmd>Telescope git_branches<cr>",                                                                                desc = "Checkout branch" },
      { "<leader>sc", "<cmd>Telescope colorscheme<cr>",                                                                                 desc = "Colorscheme" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                                                                   desc = "Find Help" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                                                                   desc = "Man Pages" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                                                                                    desc = "Open Recent File" },
      { "<leader>sR", "<cmd>Telescope registers<cr>",                                                                                   desc = "Registers" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                                                                     desc = "Keymaps" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                                                                                    desc = "Commands" },

      -- Terminal group
      { "<leader>t",  group = "Terminal" },
      { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>",                                                                                    desc = "Node" },
      { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>",                                                                                    desc = "NCDU" },
      { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>",                                                                                    desc = "Htop" },
      { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>",                                                                                  desc = "Python" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",                                                                            desc = "Float" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>",                                                               desc = "Horizontal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",                                                                 desc = "Vertical" },
    }
    -- Apply the setup and register mappings
    which_key.setup(setup)
    --which_key.register(mappings, opts)
    which_key.add(mappings)
  end
}
