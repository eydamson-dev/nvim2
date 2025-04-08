return {
	"romgrk/barbar.nvim",
	lazy = false,
  enabled = true,
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	version = "^1.0.0", -- optional: only update when a new 1.x version is released
	config = function()
		require("barbar").setup({
			tabpages = false,
			focus_on_close = "left",
			highlight_visible = true,
			highlight_inactive = true,
			icons = {
				preset = "default",
				separator_at_end = false,
				separator = {
					left = "",
					right = " 󰇙",
				},
				filetype = {
					-- Sets the icon's highlight group.
					-- If false, will use nvim-web-devicons colors
					custom_colors = false,

					-- Requires `nvim-web-devicons` if `true`
					enabled = true,
				},
			},

			sidebar_filetypes = {
				NvimTree = true,
			},
		})

		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- navigate buffers
		keymap("n", "<S-j>", "<cmd>BufferPrevious<CR>", opts)
		keymap("n", "<S-k>", "<cmd>BufferNext<CR>", opts)

		-- reorder buffers
		keymap("n", "<M-J", "<cmd>BufferMovePrevious<cr>", opts)
		keymap("n", "<M-K", "<cmd>BufferMoveNext<cr>", opts)

		-- close buffer
		keymap("n", "<C-x>", "<cmd>BufferClose<cr>", opts)
		keymap("n", "<C-q>", "<cmd>q<cr>", opts)
	end,
}
