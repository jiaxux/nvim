return {
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			require('smart-splits').setup({
				ignored_filetypes = { 'NvimTree' },
				default_amount = 3,
				at_edge = 'wrap',
				move_cursor_same_row = false,
				cursor_follows_swapped_bufs = false,
				resize_mode = {
					quit_key = '<ESC>',
					resize_keys = { 'h', 'j', 'k', 'l' },
					silent = false,
				},
			})
		end

	}
}
