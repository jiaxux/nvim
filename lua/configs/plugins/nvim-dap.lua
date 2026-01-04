return {
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Virtual text (shows variable values inline)
			local ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
			if ok then
				virtual_text.setup()
			end

			-- DAP UI setup
			dapui.setup()

			-- Auto open/close UI
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

			-- Python setup (use Mason's debugpy)
			local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(debugpy_path)

			-- Python path selector
			local function get_python_paths()
				local paths = {}
				-- Add common Python paths
				local candidates = {
					vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
					vim.fn.exepath("python3"),
					vim.fn.exepath("python"),
					vim.fn.getcwd() .. "/venv/bin/python",
					vim.fn.getcwd() .. "/.venv/bin/python",
					vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python" or nil,
					vim.env.CONDA_PREFIX and vim.env.CONDA_PREFIX .. "/bin/python" or nil,
				}
				for _, path in ipairs(candidates) do
					if path and vim.fn.executable(path) == 1 then
						table.insert(paths, path)
					end
				end
				return paths
			end

			local function select_python_path()
				local paths = get_python_paths()
				vim.ui.select(paths, {
					prompt = "Select Python interpreter:",
					format_item = function(path)
						-- Show shortened path
						local home = vim.env.HOME
						return path:gsub(home, "~")
					end,
				}, function(choice)
					if choice then
						require("dap-python").setup(choice)
						vim.notify("Python path set to: " .. choice, vim.log.levels.INFO)
					end
				end)
			end

			-- Keymap to select Python path
			vim.keymap.set("n", "<leader>dp", select_python_path, { desc = "Debug: Select Python Path" })

			-- C/C++ setup with codelldb (installed via Mason)
			local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
			if vim.fn.filereadable(codelldb_path) == 1 then
				dap.adapters.codelldb = {
					type = "server",
					port = "${port}",
					executable = {
						command = codelldb_path,
						args = { "--port", "${port}" },
					},
				}
				dap.configurations.c = {
					{
						name = "Launch file",
						type = "codelldb",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
					},
				}
				dap.configurations.cpp = dap.configurations.c
			end

			-- Keymaps (all under <leader>d prefix)
			local map = vim.keymap.set

			-- Start/Continue debugging
			map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			map("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })

			-- Stop debugging
			map("n", "<F6>", dap.terminate, { desc = "Debug: Stop" })
			map("n", "<leader>dq", dap.terminate, { desc = "Debug: Stop" })

			-- Step controls
			map("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			map("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			map("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
			map("n", "<leader>dn", dap.step_over, { desc = "Debug: Step Over (Next)" })
			map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
			map("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })

			-- Breakpoints
			map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			map("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Conditional Breakpoint" })
			map("n", "<leader>dl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Debug: Log Point" })

			-- UI
			map("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Debug: Evaluate Expression" })
			map("n", "<leader>df", function()
				dapui.float_element()
			end, { desc = "Debug: Float Element" })

			-- Run to cursor
			map("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })

			-- REPL
			map("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })

			-- Prettier breakpoint signs
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "◐", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStopped", numhl = "" })

			-- Highlight groups
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
			vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#f0a000" })
			vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
			vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })
		end,
	},
}
