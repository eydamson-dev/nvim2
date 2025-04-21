return {
	"zbirenbaum/copilot.lua",
	event = "VeryLazy",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		model = "gemini",
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuOpen",
			callback = function()
				vim.b.copilot_suggestion_hidden = true
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuClose",
			callback = function()
				vim.b.copilot_suggestion_hidden = false
			end,
		})
	end,
}
