return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- DAP Keymaps
  			vim.keymap.set('n', '<leader>dc', '<Cmd>lua require"dap".continue()<CR>')
			vim.keymap.set('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>')
		end
	},
	{
		"mfussenegger/nvim-dap-python"
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio" }
	},
}
