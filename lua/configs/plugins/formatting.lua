return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				yaml = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },
				latex = { "latexindent" },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set the log level. Use `:ConformInfo` to see the location of the log file.
			log_level = vim.log.levels.ERROR,
			-- Conform will notify you when a formatter errors
			notify_on_error = true,
			-- Conform will notify you when no formatters are available for the buffer
			notify_no_formatters = true,
			formatters = {
				my_formatter = {
					-- This can be a string or a function that returns a string.
					-- When defining a new formatter, this is the only field that is required
					command = "my_cmd",
					-- A list of strings, or a function that returns a list of strings
					-- Return a single string instead of a list to run the command in a shell
					args = { "--stdin-from-filename", "$FILENAME" },
					-- If the formatter supports range formatting, create the range arguments here
					range_args = function(self, ctx)
						return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
					end,
					-- Send file contents to stdin, read new contents from stdout (default true)
					-- When false, will create a temp file (will appear in "$FILENAME" args). The temp
					-- file is assumed to be modified in-place by the format command.
					stdin = true,
					-- A function that calculates the directory to run the command in
					cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
					-- When cwd is not found, don't run the formatter (default false)
					require_cwd = true,
					-- When stdin=false, use this template to generate the temporary file that gets formatted
					tmpfile_format = ".conform.$RANDOM.$FILENAME",
					-- When returns false, the formatter will not be used
					condition = function(self, ctx)
						return vim.fs.basename(ctx.filename) ~= "README.md"
					end,
					-- Exit codes that indicate success (default { 0 })
					exit_codes = { 0, 1 },
					-- Environment variables. This can also be a function that returns a table.
					env = {
						VAR = "value",
					},
					-- Set to false to disable merging the config with the base definition
					inherit = true,
					-- When inherit = true, add these additional arguments to the beginning of the command.
					-- This can also be a function, like args
					prepend_args = { "--use-tabs" },
					-- When inherit = true, add these additional arguments to the end of the command.
					-- This can also be a function, like args
					append_args = { "--trailing-comma" },
				},
				-- black = {
				-- 	prepend_args = { "--line-length", "79" },
				-- },
				-- These can also be a function that returns the formatter
				other_formatter = function(bufnr)
					return {
						command = "my_cmd",
					}
				end,
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = false, -- Set to false to ensure callback is triggered
				timeout_ms = 5000,
			})
		end)
	end,
}
