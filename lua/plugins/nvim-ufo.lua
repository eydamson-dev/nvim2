return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldcolumn = "auto" -- '0' is not bad
		vim.o.foldlevel = 99-- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = false

		local ftMap = {
			vim = "indent",
			python = { "indent" },
			git = "",
		}

		local ufo = require("ufo")
		ufo.setup({
			open_fold_hl_timeout = 150,
			close_fold_kinds_for_ft = {
				default = { "imports", "comment" },
				json = { "array" },
				c = { "comment", "region" },
			},
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
			provider_selector = function(bufnr, filetype, buftype)
				-- if you prefer treesitter provider rather than lsp,
				return ftMap[filetype] or {'treesitter', 'indent'}
			end,
		})

		vim.keymap.set("n", "zR", ufo.openAllFolds)
		vim.keymap.set("n", "zM", ufo.closeAllFolds)
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
		vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
		vim.keymap.set("n", "L", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				-- choose one of coc.nvim and nvim lsp
				vim.fn.CocActionAsync("definitionHover") -- coc.nvim
				vim.lsp.buf.hover()
			end
		end)
	end,
}
