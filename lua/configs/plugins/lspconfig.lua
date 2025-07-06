-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  We extend the capabilities with nvim-cmp to support more features.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
--
-- This can vary by config, but in general for nvim-lspconfig:

return {
	"neovim/nvim-lspconfig",

	-- example using `opts` for defining servers
	opts = {
		servers = {
			lua_ls = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
						preselectSupport = true,
						insertReplaceSupport = true,
						labelDetailsSupport = true,
						deprecatedSupport = true,
						commitCharactersSupport = true,
						tagSupport = { valueSet = { 1 } },
						resolveSupport = {
							properties = {
								"documentation",
								"detail",
								"additionalTextEdits",
							},
						},
					},
					contextSupport = true,
					dynamicRegistration = true,
				},
			},
		})
		for server, config in pairs(opts.servers) do
			config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
			lspconfig[server].setup(config)
		end
	end,

	-- example calling setup directly for each LSP
	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
						preselectSupport = true,
						insertReplaceSupport = true,
						labelDetailsSupport = true,
						deprecatedSupport = true,
						commitCharactersSupport = true,
						tagSupport = { valueSet = { 1 } },
						resolveSupport = {
							properties = {
								"documentation",
								"detail",
								"additionalTextEdits",
							},
						},
					},
					contextSupport = true,
					dynamicRegistration = true,
				},
			},
		})
		local lspconfig = require("lspconfig")

		-- Define on_attach function for key mappings
		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			-- Buffer local mappings
			local opts = { noremap = true, silent = true, buffer = bufnr }

			-- Go to definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gv", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
			vim.keymap.set("n", "gn", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)

			-- Optional: Add other useful LSP keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		end

		-- Setup each LSP server with capabilities and key mappings
		local servers = { "texlab", "lua_ls" }
		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Special setup for pyright to use the correct Python environment
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
					},
					-- Pyright will look for a Python environment in this order:
					-- 1. pyproject.toml in the workspace
					-- 2. poetry.lock in the workspace
					-- 3. requirements.txt in the workspace
					-- 4. venv directory in the workspace
					-- 5. .venv directory in the workspace
					-- 6. If none found, it will use the path specified here
					pythonPath = vim.fn.exepath("python"), -- This will use the Python in your PATH
				},
			},
		})

		-- Special setup for clangd with offset encoding
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
		})
	end,
}
