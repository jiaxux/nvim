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
opt.smartindent = true
opt.colorcolumn = "80"
opt.splitright = true
opt.showmode = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false


-- Plugin Configurations

-- Vimtex
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = 'abdmg'



