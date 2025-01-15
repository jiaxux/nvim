return {
	{
		"kdheepak/lazygit.nvim",
		config = function()
			-- LazyGit settings
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_boarder_chars = { '╭', '╮', '╰', '╯' }
			vim.g.lazygit_use_neovim_remote = 1
			vim.keymap.set("n", "<c-g>", ":LazyGit<CR>")
		end
	},
}
