return {
	{
		"folke/flash.nvim",
		config=function()
		require('flash').setup({
			flash_on_start = true,
			modes = {
			char = {
				jump_labels = true
			},
			search = {
				enabled = true,
				highlight = {
					backdrop = true,
				},
				jump = {
					autojump = true,
				},
			}
		},
	})


		end,
	}
}
