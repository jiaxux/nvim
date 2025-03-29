return {
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("smart-splits").setup({
				ignored_filetypes = { "NvimTree" },
				default_amount = 3,
				at_edge = "wrap",
				move_cursor_same_row = false,
				cursor_follows_swapped_bufs = false,
				resize_mode = {
					quit_key = "<ESC>",
					resize_keys = { "h", "j", "k", "l" },
					silent = false,
				},
			})

			vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
			vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
			vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
			vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
			vim.keymap.set("n", "<Leader>l", "<Cmd>noh<CR>")
		end,
	},
}
