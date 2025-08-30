return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf_lua = require("fzf-lua")
			
			fzf_lua.setup({
				previewer = {
					builtin = {
						-- Disable snacks integration for previews to avoid conflicts
						extensions = {
							["png"] = { "viu", "{file}" },
							["jpg"] = { "viu", "{file}" },
							["jpeg"] = { "viu", "{file}" },
							["gif"] = { "viu", "{file}" },
							["webp"] = { "viu", "{file}" },
						},
						-- Force use of builtin previewer instead of snacks
						ueberzug_scaler = "cover",
						title_fnamemodify = function(s) return vim.fn.fnamemodify(s, ":t") end,
					},
				},
				files = {
					previewer = "builtin",
					git_icons = false,
					file_icons = true,
					color_icons = true,
					preview_opts = "hidden",
				},
				grep = {
					previewer = "builtin",
				},
				buffers = {
					previewer = "builtin",
				},
				-- Ensure fzf-lua handles its own floating window
				winopts = {
					preview = {
						default = "builtin",
						-- Prevent conflicts with snacks window management
						border = "rounded",
						wrap = "nowrap",
						hidden = "nohidden",
						vertical = "down:45%",
						horizontal = "right:50%",
						layout = "flex",
						flip_columns = 120,
					},
				},
			})
			
			vim.keymap.set("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>")
			vim.keymap.set("n", "<c-s-B>", "<cmd>lua require('fzf-lua').buffers()<CR>")
			vim.keymap.set("n", "<c-f>", "<cmd>lua require('fzf-lua').live_grep()<CR>")
			vim.keymap.set("n", "<C-A-f>", "<cmd>lua require('fzf-lua').grep_project()<CR>")
		end
	}
}
