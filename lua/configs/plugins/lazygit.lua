-- nvim v0.8.0
return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- order to load the plugin when the command is run for the first time
	keys = {
		{ "<c-g>", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	},
	config = function()
		-- LazyGit settings
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 1.0
		vim.g.lazygit_floating_window_boarder_chars = { "╭", "╮", "╰", "╯" }
		vim.g.lazygit_use_neovim_remote = 1
	end,
}
