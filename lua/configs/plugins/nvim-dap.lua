return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- DAP Keymaps
			vim.keymap.set("n", "<leader>dc", '<Cmd>lua require"dap".continue()<CR>')
			vim.keymap.set("n", "<leader>db", '<Cmd>lua require"dap".toggle_breakpoint()<CR>')
			require("dap-python").setup("/home/jixing/mambaforge/envs/fly-habitat/bin/python")
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
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
}
