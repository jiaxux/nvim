return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.maplocalleader = "\\" -- Set local leader to backslash
		-- Ensure VimTeX uses latex filetype
		vim.g.tex_flavor = "latex"
		-- Enable compiler, viewer, and key mappings
		vim.g.vimtex_compiler_enabled = 1
		vim.g.vimtex_view_enabled = 1
		vim.g.vimtex_mappings_enabled = 1
	end,
	ft = { "tex", "latex" }
}
