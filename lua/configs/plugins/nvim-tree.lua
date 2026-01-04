return {
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 35,
				},
			})
		end,
	},
}
