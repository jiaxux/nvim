return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 5000 })
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			yaml = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			markdown = { "prettier" },
			latex = { "latexindent" },
			["*"] = { "codespell" },
			["_"] = { "trim_whitespace" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
		notify_no_formatters = true,
	},
}
