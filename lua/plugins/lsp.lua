return {
	"neovim/nvim-lspconfig", -- now treated as a bag of server configs
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local blinkcmp = require("blink.cmp")
		local capabilities = blinkcmp.get_lsp_capabilities({}, true)

		local function organize_imports()
			local params = {
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
			}
			vim.lsp.buf.execute_command(params)
		end

		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = false,
			ensure_installed = {
				"bashls",
				"cssmodules_ls",
				"eslint",
				"html",
				"jsonls",
				"lua_ls",
				"vtsls",
				"yamlls",
			},
			-- Removed `handlers`, using native config instead
		})

		-- For each LSP you want to configure specifically:
		local lsp = vim.lsp

		-- Example for vtsls with organizeImports and formatting override
		lsp.enable("vtsls")
		lsp.config("vtsls", {
			capabilities = capabilities,
			commands = {
				OrganizeImports = {
					organize_imports,
					description = "Organize Imports",
				},
			},
			on_attach = function(client, bufnr)
				local orig_format = vim.lsp.buf.format
				vim.lsp.buf.format = function(opts)
					organize_imports()
					orig_format(opts)
				end
			end,
		})

		-- For other servers, you can set default or no custom config
		for _, server in ipairs({
			"bashls",
			"cssmodules_ls",
			"eslint",
			"html",
			"jsonls",
			"lua_ls",
			"yamlls",
		}) do
			lsp.enable(server)
			lsp.config(server, { capabilities = capabilities })
		end

		-- Enable all listed servers automatically if you prefer:
		-- require("mason-lspconfig").setup({
		--   automatic_enable = true,
		--   ensure_installed = { ... },
		-- })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", ":Lspsaga goto_definition<cr>", opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})

		local wk = require("which-key")
		wk.add({
			{ "<leader>l", group = "LSP" },
			{ "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Actions" },
			{ "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostic" },
			{ "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
			{ "<leader>lh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover" },
			{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
			{ "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info" },
			{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
			{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
			{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
			{ "<leader>lq", "<cmd>lua vim.diagnostic.set_loclist()<cr>", desc = "Quickfix" },
			{ "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
			{ "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
		})
	end,
}
