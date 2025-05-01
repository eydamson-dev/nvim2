return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_autoinsert    = 1
    vim.g.floaterm_width         = 0.9
    vim.g.floaterm_height        = 0.9
    vim.g.floaterm_wintitle      = 1
    vim.g.floaterm_autoclose     = 1

    local keymap = vim.keymap.set
    keymap("n", "<leader>1", ":FloatermToggle<CR>", { noremap = true, silent = true })
    keymap("t", "<leader>1", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })
    keymap("n", "<leader>2", ":FloatermNext<CR>", { noremap = true, silent = true })
    keymap("t", "<leader>2", "<C-\\><C-n>:FloatermNext<CR>", { noremap = true, silent = true })
    keymap("n", "<leader>3", ":FloatermPrev<CR>", { noremap = true, silent = true })
    keymap("t", "<leader>3", "<C-\\><C-n>:FloatermPrev<CR>", { noremap = true, silent = true })
    keymap("n", "<leader>4", ":FloatermNew<CR>", { noremap = true, silent = true })
    keymap("t", "<leader>4", "<C-\\><C-n>:FloatermNew<CR>", { noremap = true, silent = true })
  end
}

