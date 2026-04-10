---@diagnostic disable: undefined-global
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
opt.smartindent = false
opt.colorcolumn = "89"
opt.splitright = true
opt.showmode = false
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false
opt.signcolumn = "yes"

-- Built-in treesitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start)
		local disabled_indent = { yaml = true, dart = true }
		if not disabled_indent[vim.bo[args.buf].filetype] then
			vim.bo[args.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
		end
	end,
})
-- Virtual Lines
-- vim.diagnostic.config({
-- 	-- Use the default configuration
-- 	virtual_lines = true,

-- 	-- Alternatively, customize specific options
-- 	-- virtual_lines = {
-- 	--  -- Only show virtual line diagnostics for the current cursor line
-- 	--  current_line = true,
-- 	-- },
-- })

-- Vimtex
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = "abdmg"
