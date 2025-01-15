return {
	{
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			-- CoC extensions
			vim.g.coc_global_extensions = {
				'coc-pyright',
				'coc-yank',
				'coc-clangd',
				'coc-yaml',
				'coc-pairs',
				'coc-cmake',
				'coc-vimlsp',
				'coc-prettier',
				'coc-marketplace',
				'coc-vimtex',
				'coc-lua',
				'coc-markdown-preview-enhanced',
				'coc-prettier'
			},
            -- CoC mappings
            vim.keymap.set("n", "gv", ":vsp<CR><Plug>(coc-definition)", { silent = true })
            vim.keymap.set("n", "gd", ":call CocAction('jumpDefinition')<CR>", { silent = true })
            vim.keymap.set("n", "gn", ":call CocAction('jumpDefinition', 'tabe')<CR>", { silent = true })
            vim.keymap.set("n", "<c-o>", ":CocOutline<CR>")
            vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)")
            vim.keymap.set("n", "<leader>r", "<Plug>(coc-references)")
            vim.keymap.set("n", "<c-y>", ":<C-u>CocList -A --normal yank<cr>", { silent = true })
		end,
	}
}

