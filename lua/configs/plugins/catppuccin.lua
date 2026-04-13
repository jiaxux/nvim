return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha",
		color_overrides = {
			mocha = {
				base = "#1f1f28",
				mantle = "#1a1a23",
				crust = "#16161e",
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd([[colorscheme catppuccin]])
	end,
}
