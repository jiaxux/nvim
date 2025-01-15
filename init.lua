-- bootstrap lazy.nvim
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

-- Basic Options
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- General Settings
local opt = vim.opt
opt.compatible = false
opt.swapfile = false
opt.backup = false
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartindent = true
opt.colorcolumn = "80"
opt.splitright = true
opt.showmode = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- Plugin Specification
require("lazy").setup({
	-- Themes
	{ "rebelot/kanagawa.nvim" },

	-- Essential plugins
	{ "github/copilot.vim" },
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{ "tpope/vim-fugitive" },
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	{
		"neoclide/coc.nvim",
		branch = "release"
	},
	{ "tpope/vim-commentary" },
	{ "fisadev/vim-isort" },
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	{ "kylechui/nvim-surround" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	{ "lervag/vimtex" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "folke/flash.nvim" },
	{ "kdheepak/lazygit.nvim" },
	{ "mrjones2014/smart-splits.nvim" },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	{
		'alexghergh/nvim-tmux-navigation',
		config = function()
			local nvim_tmux_nav = require('nvim-tmux-navigation')

			nvim_tmux_nav.setup {
				disable_when_zoomed = true -- defaults to false
			}

			vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
			vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
			vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
			vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
			vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
			vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
		end
	},
	{ "mfussenegger/nvim-dap" },
	{ "mfussenegger/nvim-dap-python" },
	{ "nvim-neotest/nvim-nio" },
	{ "rcarriga/nvim-dap-ui" },
	{ "stevearc/dressing.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{
		"yetone/avante.nvim",
		branch = "main",
		build = "make"
	},
})

-- Key Mappings
local keymap = vim.keymap.set

-- General mappings
keymap("n", "gr", "gT")
keymap("n", "<C-A-l>", ":call CocAction('format')<CR>")
keymap("n", "<C-A-o>", ":Isort<CR>")
keymap("t", "<Esc>", "<C-\\><C-n>")

-- FZF lua mappings
keymap("n", "<c-P>", "<cmd>lua require('fzf-lua').files()<CR>")
keymap("n", "<c-s-B>", "<cmd>lua require('fzf-lua').buffers()<CR>")
keymap("n", "<c-f>", "<cmd>lua require('fzf-lua').live_grep()<CR>")
keymap("n", "<C-A-f>", "<cmd>lua require('fzf-lua').grep_project()<CR>")

-- CoC mappings
keymap("n", "gv", ":vsp<CR><Plug>(coc-definition)", { silent = true })
keymap("n", "gd", ":call CocAction('jumpDefinition')<CR>", { silent = true })
keymap("n", "gn", ":call CocAction('jumpDefinition', 'tabe')<CR>", { silent = true })
keymap("n", "<c-o>", ":CocOutline<CR>")
keymap("n", "<leader>rn", "<Plug>(coc-rename)")
keymap("n", "<leader>r", "<Plug>(coc-references)")
keymap("n", "<c-y>", ":<C-u>CocList -A --normal yank<cr>", { silent = true })

-- LazyGit mappings
keymap("n", "<c-g>", ":LazyGit<CR>")

-- Commands
vim.cmd([[
  command! WQ wq
  command! Wq wq
  command! W w
  command! Q q
  command! Nt NvimTreeToggle
  command! St SyntasticToggleMode
  command! Dv DiffviewOpen
  command! Df DiffviewFileHistory
  command! Dc DiffviewClose
  command! Dcl DiffClipboard
]])

-- Plugin Configurations

-- Vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'

-- CoC extensions
vim.g.coc_global_extensions = {
	'coc-pyright',
	'coc-yank',
	'coc-clangd',
	'coc-yaml',
	'coc-pairs',
	'coc-cmake',
	'coc-vimlsp',
	'coc-prettier',
	'coc-marketplace',
	'coc-vimtex',
	'coc-markdown-preview-enhanced',
	'coc-prettier'
}

-- LazyGit settings
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 1.0
vim.g.lazygit_floating_window_boarder_chars = { '╭', '╮', '╰', '╯' }
vim.g.lazygit_use_neovim_remote = 1

-- Plugin Setup Calls
require("nvim-tree").setup({
	view = {
		width = 35,
	},
})

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

require("dap-python").setup("/home/jixing/mambaforge/envs/fly-habitat/bin/python")

require('flash').setup({
	flash_on_start = true,
	modes = {
		char = {
			jump_labels = true
		},
		search = {
			enabled = true,
			highlight = {
				backdrop = true,
			},
			jump = {
				autojump = true,
			},
		}
	},
})

require('nvim-treesitter.configs').setup({
	ensure_installed = "all",
	highlight = { enable = true },
	indent = { enable = false }
})

require("ibl").setup({
	scope = { enabled = false },
})

require('nvim-tmux-navigation').setup({
	disable_when_zoomed = true
})

require('smart-splits').setup({
	ignored_filetypes = { 'NvimTree' },
	default_amount = 3,
	at_edge = 'wrap',
	move_cursor_same_row = false,
	cursor_follows_swapped_bufs = false,
	resize_mode = {
		quit_key = '<ESC>',
		resize_keys = { 'h', 'j', 'k', 'l' },
		silent = false,
	},
})

require("nvim-surround").setup()

require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		globalstatus = false,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
})

-- DAP UI Setup
local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- DAP Keymaps
keymap('n', '<leader>dc', '<Cmd>lua require"dap".continue()<CR>')
keymap('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>')

-- Set colorscheme
vim.cmd([[colorscheme kanagawa]])
