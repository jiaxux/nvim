return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons"},
		config = function()
			require("nvim-tree").setup({
				view = {
					width = 35,
				},
			})
		end,
	}
}
