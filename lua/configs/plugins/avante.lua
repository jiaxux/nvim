return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			provider = "gemini", -- default provider, can be openai, gemini, claude, deepseek
			providers = {
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					extra_request_body = {
						temperature = 0,
						max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
						reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
					},
				},
				gemini = {
					model = "gemini-2.5-flash-preview-05-20", -- your desired model
					extra_request_body = {
						temperature = 0,
						max_tokens = 30000, -- Increase this to include reasoning tokens (for reasoning models)
						max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					},
				},
				claude = {
					endpoint = 'https://api.anthropic.com',
					model = 'claude-sonnet-4-20250514',
					timeout = 15000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.2,
						max_tokens = 20480, -- Increase this to include reasoning tokens (for reasoning models)
					},
				},
				deepseek = {
					__inherited_from = "openai",
					api_key_name = "DEEPSEEK_API_KEY",
					endpoint = "https://api.deepseek.com/v1",
					model = "deepseek-coder",
					extra_request_body = {
						-- DeepSeek does not support reasoning models yet
						temperature = 0,
						max_completion_tokens = 4096,
					},
				},
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
