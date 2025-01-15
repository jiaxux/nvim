return {
	{
		"yetone/avante.nvim",
		branch = "main",
		build = "make",
		config=function()
			require('avante_lib').load()
			require('avante').setup({
			provider = "claude",
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-5-sonnet-20241022",
				temperature = 0,
				max_tokens = 4096,
			},
		})
		end,
	},
}
