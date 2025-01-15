require("configs.defaults")
require("configs.keymaps")
require("configs.plugins")

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

