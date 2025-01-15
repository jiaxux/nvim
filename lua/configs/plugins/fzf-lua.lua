return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>")
			vim.keymap.set("n", "<c-s-B>", "<cmd>lua require('fzf-lua').buffers()<CR>")
			vim.keymap.set("n", "<c-f>", "<cmd>lua require('fzf-lua').live_grep()<CR>")
			vim.keymap.set("n", "<C-A-f>", "<cmd>lua require('fzf-lua').grep_project()<CR>")
		end
	}
}
