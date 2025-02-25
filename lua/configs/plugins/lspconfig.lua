-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  With blink.cmp, Neovim has *more* capabilities which are communicated to the LSP servers.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
--
-- This can vary by config, but in general for nvim-lspconfig:

return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },

	-- example using `opts` for defining servers
	opts = {
		servers = {
			lua_ls = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,

	-- example calling setup directly for each LSP
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
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

			-- Document symbols/outline
			vim.keymap.set("n", "<leader>o", function()
				vim.fn.setqflist({}) -- Clear quickfix list
				vim.lsp.buf.document_symbol()
			end, opts)
		end

		-- Setup each LSP server with capabilities and key mappings
		local servers = { "pyright", "texlab", "lua_ls" }
		for _, server in ipairs(servers) do
			lspconfig[server].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

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
