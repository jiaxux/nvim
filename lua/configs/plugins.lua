---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Specification
require("lazy").setup({
	require("configs.plugins.kanagawa"),
	require("configs.plugins.diffview"),
	require("configs.plugins.fzf-lua"),
	require("configs.plugins.yanky"),
	require("configs.plugins.outline"),
	require("configs.plugins.snacks"),
	require("configs.plugins.tiny-inline-diagnostics"),
	require("configs.plugins.lspconfig"),
	require("configs.plugins.claudecode"),
	require("configs.plugins.formatting"),
	require("configs.plugins.nvim-lint"),
	require("configs.plugins.nvim-cmp"),
	require("configs.plugins.commentary"),
	require("configs.plugins.lazygit"),
	require("configs.plugins.nvim-tree"),
	require("configs.plugins.nvim-surround"),
	require("configs.plugins.lualine"),
	require("configs.plugins.vimtex"),
	require("configs.plugins.neoscroll"),
	require("configs.plugins.nvim-autopairs"),
	require("configs.plugins.flash"),
	require("configs.plugins.smart-splits"),
	require("configs.plugins.gitsigns"),
	require("configs.plugins.nvim-treesitter"),
	require("configs.plugins.nvim-tmux-navigation"),
	require("configs.plugins.nvim-dap"),
	require("configs.plugins.dressing"),
	require("configs.plugins.nui"),
	require("configs.plugins.outline"),
	require("configs.plugins.avante"),
})

