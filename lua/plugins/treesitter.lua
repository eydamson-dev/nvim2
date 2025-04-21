return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local status_ok, configs = pcall(require, "nvim-treesitter.configs")
		if not status_ok then
			return
		end

		configs.setup({
			modules = {},
			ignore_install = {},
			-- A list of parser names, or "all" (the five listed parsers should always be installed)
			ensure_installed = { "lua", "css", "scss","html", "javascript", "typescript", "json" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			-- List of parsers to ignore installing (or "all")
			-- ignore_install = { "javascript" },

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
		})

		-- local vim = vim
		-- local opt = vim.opt
		-- opt.foldmethod = "expr"
		-- opt.foldexpr = "nvim_treesitter#foldexpr()"
		-- opt.nofoldenable = true

		-- vim.cmd [[
		--   set foldmethod=expr
		--   set foldexpr=nvim_treesitter#foldexpr()
		--   set nofoldenable                     " Disable folding at startup.
		-- ]]
		--

		-- vim.cmd([[
		--   autocmd BufReadPost,FileReadPost * normal zi
		-- ]])
	end,
}
