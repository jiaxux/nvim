return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim", build = ":MasonUpdate", },
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_language_server",
				"pyright",
				"clangd",
				"prettier",
				"texlab",
				"yaml-language-server",
				"black",
				"clang-format",
				"codelldb",
				"cmake",
			},
			automatic_installation = true,
		})
	end
}
