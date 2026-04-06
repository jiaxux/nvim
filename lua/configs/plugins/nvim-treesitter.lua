return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		priority = 1000,
		build = ":TSUpdate",
		main = "nvim-treesitter",
		init = function()
			-- Disable smartindent since treesitter handles indentation
			vim.opt.smartindent = false

			-- Ensure parsers are installed (only installs missing ones)
			local ensureInstalled = {
				"bash",
				"c",
				"cpp",
				"css",
				"dart",
				"fish",
				"go",
				"html",
				"javascript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			if #parsersToInstall > 0 then
				require("nvim-treesitter").install(parsersToInstall)
			end

			-- Enable treesitter features via FileType autocmd
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					-- Try to start treesitter highlighting
					pcall(vim.treesitter.start)

					-- Enable treesitter indentation (except for yaml and dart)
					local disabled_indent = { yaml = true, dart = true }
					if not disabled_indent[vim.bo[args.buf].filetype] then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			-- Incremental selection keymaps
			vim.keymap.set("n", "<c-n>", function()
				require("nvim-treesitter.incremental_selection").init_selection()
			end, { desc = "Init treesitter selection" })
			vim.keymap.set("v", "<c-n>", function()
				require("nvim-treesitter.incremental_selection").node_incremental()
			end, { desc = "Increment treesitter selection" })
			vim.keymap.set("v", "<c-h>", function()
				require("nvim-treesitter.incremental_selection").node_decremental()
			end, { desc = "Decrement treesitter selection" })
			vim.keymap.set("v", "<c-l>", function()
				require("nvim-treesitter.incremental_selection").scope_incremental()
			end, { desc = "Increment treesitter scope" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local tscontext = require("treesitter-context")
			tscontext.setup({
				enable = true,
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			vim.keymap.set("n", "[c", function()
				tscontext.go_to_context()
			end, { silent = true })
		end,
	},
}
