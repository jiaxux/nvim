return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- DAP Keymaps
			-- Basic debugging
			vim.keymap.set("n", "<leader>dc", '<Cmd>lua require"dap".continue()<CR>', { desc = "Debug: Continue" })
			vim.keymap.set(
				"n",
				"<leader>db",
				'<Cmd>lua require"dap".toggle_breakpoint()<CR>',
				{ desc = "Debug: Toggle Breakpoint" }
			)

			-- UI control
			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>de", function()
				require("dapui").eval()
			end, { desc = "Debug: Evaluate Expression" })
			vim.keymap.set("v", "<leader>de", function()
				require("dapui").eval()
			end, { desc = "Debug: Evaluate Expression" })
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
