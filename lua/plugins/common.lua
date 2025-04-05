return {
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},
	-- "nvim-tree/nvim-web-devicons",
	-- { "echasnovski/mini.nvim", enable = false, version = "*" },
	-- {
	-- 	enable = false,
	-- 	"echasnovski/mini.icons",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.icons").setup()
	-- 	end,
	-- },
}
