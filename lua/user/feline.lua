-- require('feline').setup()
require("feline").setup {
	preset = "default",
	custom_providers = {
		lsp_status = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp-status").status() or ""
		end,

		lsp_progress = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp").lsp_progress() or ""
		end,

		lsp_client_offset_encoding = function()
			local clients = {}
			for _, client in pairs(vim.lsp.buf_get_clients(0)) do
				clients[#clients + 1] = client.name .. ": " .. client.offset_encoding
			end
			return table.concat(clients, ", "), "⚙️"
		end,
	},
}
