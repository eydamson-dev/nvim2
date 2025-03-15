return {
  'phaazon/hop.nvim',
  config = function()
    require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    local keymap = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    keymap("n", "zh", ":HopWord<CR>", opts)
  end
}

