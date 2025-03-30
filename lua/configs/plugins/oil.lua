return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	-- Open directories in current window
	vim.keymap.set("n", "-", function()
		require("oil").open_float(vim.fn.expand("%:p:h"))
	end, { desc = "Open parent directory" }),
}
