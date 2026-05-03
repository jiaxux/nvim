-- LSP servers and clients communicate which features they support through "capabilities".
--  By default, Neovim supports a subset of the LSP specification.
--  We extend the capabilities with nvim-cmp to support more features.
--  Explanation from TJ: https://youtu.be/m8C0Cq9Uv9o?t=1275
--
-- This can vary by config, but in general for nvim-lspconfig:

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
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

		-- Define on_attach function for key mappings
		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

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

		-- Setup each LSP server using vim.lsp.config
		local servers = { "texlab", "lua_ls" }
		for _, server in ipairs(servers) do
			vim.lsp.config(server, {
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Helper: Find Python interpreter in project
		local function get_python_path(workspace)
			local cwd = workspace or vim.fn.getcwd()

			-- Check for virtualenv in common locations
			local venv_paths = {
				cwd .. "/.venv/bin/python",
				cwd .. "/venv/bin/python",
				cwd .. "/.env/bin/python",
				cwd .. "/env/bin/python",
			}
			for _, path in ipairs(venv_paths) do
				if vim.fn.executable(path) == 1 then
					return path
				end
			end

			-- Check for poetry
			if vim.fn.filereadable(cwd .. "/poetry.lock") == 1 then
				local poetry_venv = vim.fn.trim(vim.fn.system("cd " .. cwd .. " && poetry env info -p 2>/dev/null"))
				if poetry_venv ~= "" and vim.fn.isdirectory(poetry_venv) == 1 then
					local poetry_python = poetry_venv .. "/bin/python"
					if vim.fn.executable(poetry_python) == 1 then
						return poetry_python
					end
				end
			end

			-- Check for conda env (CONDA_PREFIX)
			local conda_prefix = os.getenv("CONDA_PREFIX")
			if conda_prefix then
				local conda_python = conda_prefix .. "/bin/python"
				if vim.fn.executable(conda_python) == 1 then
					return conda_python
				end
			end

			-- Fallback to system python
			return vim.fn.exepath("python3") or vim.fn.exepath("python")
		end

		-- Store current python path per workspace
		vim.g.python_host_prog = get_python_path()

		-- Setup pyright with auto-detected Python
		vim.lsp.config("pyright", {
			capabilities = capabilities,
			on_attach = on_attach,
			on_init = function(client)
				local python_path = get_python_path(client.config.root_dir)
				client.config.settings.python.pythonPath = python_path
				vim.notify("Python: " .. python_path, vim.log.levels.INFO)
			end,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace",
						typeCheckingMode = "basic",
					},
				},
			},
		})

		-- Command to select Python interpreter manually
		vim.api.nvim_create_user_command("PythonSelectInterpreter", function()
			local fzf = require("fzf-lua")
			local cwd = vim.fn.getcwd()

			-- Gather possible interpreters
			local interpreters = {}
			local seen = {}

			local function add_interpreter(path, label)
				if path and vim.fn.executable(path) == 1 and not seen[path] then
					seen[path] = true
					table.insert(interpreters, { path = path, label = label or path })
				end
			end

			-- Local venvs
			for _, dir in ipairs({ ".venv", "venv", ".env", "env" }) do
				add_interpreter(cwd .. "/" .. dir .. "/bin/python", dir .. " (local)")
			end

			-- Poetry
			if vim.fn.filereadable(cwd .. "/poetry.lock") == 1 then
				local poetry_venv = vim.fn.trim(vim.fn.system("cd " .. cwd .. " && poetry env info -p 2>/dev/null"))
				if poetry_venv ~= "" then
					add_interpreter(poetry_venv .. "/bin/python", "poetry")
				end
			end

			-- Conda envs - check common locations
			local home = os.getenv("HOME")
			local conda_base_dirs = {
				home .. "/miniconda3",
				home .. "/anaconda3",
				home .. "/miniforge3",
				home .. "/mambaforge",
				home .. "/.conda",
				"/opt/conda",
				"/opt/miniconda3",
				"/opt/anaconda3",
			}

			for _, base in ipairs(conda_base_dirs) do
				-- Add base env
				local base_python = base .. "/bin/python"
				if vim.fn.executable(base_python) == 1 then
					add_interpreter(base_python, "conda: base")
				end

				-- Add all envs in envs/ folder
				local envs_dir = base .. "/envs"
				if vim.fn.isdirectory(envs_dir) == 1 then
					local envs = vim.fn.glob(envs_dir .. "/*/bin/python", false, true)
					for _, env_python in ipairs(envs) do
						local env_name = vim.fn.fnamemodify(vim.fn.fnamemodify(env_python, ":h:h"), ":t")
						add_interpreter(env_python, "conda: " .. env_name)
					end
				end
			end

			-- System pythons
			add_interpreter(vim.fn.exepath("python3"), "system python3")
			add_interpreter(vim.fn.exepath("python"), "system python")

			-- Show picker
			local items = {}
			for _, interp in ipairs(interpreters) do
				table.insert(items, interp.label .. " -> " .. interp.path)
			end

			fzf.fzf_exec(items, {
				prompt = "Select Python Interpreter> ",
				actions = {
					["default"] = function(selected)
						if selected and #selected > 0 then
							local path = selected[1]:match("-> (.+)$")
							if path then
								-- Update pyright settings
								for _, client in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
									client.config.settings.python.pythonPath = path
									client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
								end
								vim.g.python_host_prog = path
								vim.notify("Python set to: " .. path, vim.log.levels.INFO)
							end
						end
					end,
				},
			})
		end, { desc = "Select Python interpreter for LSP" })

		-- Keymap for quick access
		vim.keymap.set("n", "<leader>pi", "<cmd>PythonSelectInterpreter<CR>", { desc = "Select Python Interpreter" })

		-- Docker: Sync packages from container to local venv for LSP
		vim.api.nvim_create_user_command("PythonSyncDocker", function()
			local fzf = require("fzf-lua")
			local cwd = vim.fn.getcwd()

			-- Get running containers
			local containers_raw = vim.fn.system("docker ps --format '{{.Names}}'")
			if vim.v.shell_error ~= 0 then
				vim.notify("Docker not running or no containers found", vim.log.levels.WARN)
				return
			end

			local containers = vim.split(vim.fn.trim(containers_raw), "\n")
			if #containers == 0 or containers[1] == "" then
				vim.notify("No running containers", vim.log.levels.WARN)
				return
			end

			fzf.fzf_exec(containers, {
				prompt = "Select Docker container> ",
				actions = {
					["default"] = function(selected)
						if not selected or #selected == 0 then return end
						local container = selected[1]

						-- Create local .venv if it doesn't exist
						local venv_path = cwd .. "/.venv"
						if vim.fn.isdirectory(venv_path) == 0 then
							vim.notify("Creating .venv...", vim.log.levels.INFO)
							vim.fn.system("python3 -m venv " .. venv_path)
						end

						-- Get requirements from container and install locally
						vim.notify("Syncing packages from " .. container .. "...", vim.log.levels.INFO)
						local cmd = string.format(
							"docker exec %s pip freeze > /tmp/docker_requirements.txt && %s/bin/pip install -r /tmp/docker_requirements.txt",
							container, venv_path
						)

						vim.fn.jobstart(cmd, {
							on_exit = function(_, code)
								if code == 0 then
									vim.notify("Synced! Restart LSP with :LspRestart", vim.log.levels.INFO)
									-- Update pyright to use the new venv
									for _, client in ipairs(vim.lsp.get_clients({ name = "pyright" })) do
										client.config.settings.python.pythonPath = venv_path .. "/bin/python"
										client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
									end
								else
									vim.notify("Sync failed. Check container has pip.", vim.log.levels.ERROR)
								end
							end,
						})
					end,
				},
			})
		end, { desc = "Sync Python packages from Docker container" })

		vim.keymap.set("n", "<leader>pd", "<cmd>PythonSyncDocker<CR>", { desc = "Sync Python from Docker" })

		-- Special setup for clangd with offset encoding
		vim.lsp.config("clangd", {
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
