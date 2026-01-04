---@diagnostic disable: undefined-global
-- Key Mappings
local keymap = vim.keymap.set

-- General mappings
keymap("n", "gr", "<cmd>tabprevious<CR>", { nowait = true })
keymap("n", "<leader>n", "<cmd>NvimTreeToggle<CR>", { nowait = true })
keymap("t", "<Esc>", "<C-\\><C-n>")

-- Diff clipboard function
local function diff_clipboard()
	-- Create a new temporary buffer in a vertical split
	vim.cmd("vnew")
	-- Get the clipboard content
	local clipboard_content = vim.fn.getreg("+"):gsub("\r\n?", "\n")
	-- Put clipboard content into the new buffer
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(clipboard_content, "\n"))
	-- Set the buffer as non-modifiable and temporary
	vim.bo.modified = false
	vim.bo.modifiable = false
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	-- Enable diff mode for both windows
	vim.cmd("windo diffthis")
end

-- Commands
vim.cmd([[
  command! WQ wq
  command! Wq wq
  command! W w
  command! Q q
  command! Os ObsidianSearch
  command! Oo ObsidianOpen
  command! On ObsidianNew
  command! Dv DiffviewOpen
  command! Df DiffviewFileHistory
  command! Dc DiffviewClose
  ]])
-- Register DiffClipboard command
vim.api.nvim_create_user_command("DiffClipboard", diff_clipboard, {})
