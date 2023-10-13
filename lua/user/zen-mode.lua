local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
-- Shorten function name

keymap("n", "<leader>z", ":ZenMode<CR>", opts)
