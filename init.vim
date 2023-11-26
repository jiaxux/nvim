" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Disable swap files
set noswapfile

" Change Leader to ,
let mapleader = ","

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Setup for coc.nvim
set splitright
nmap <silent> gv :vsp<CR><Plug>(coc-definition)
nmap <silent> gd :call CocAction('jumpDefinition')<CR>
noremap <c-o> :CocOutline<CR>
let g:coc_global_extensions = ['coc-pyright', 'coc-clangd', 'coc-yaml', 'coc-cmake', 'coc-vimlsp','coc-prettier','coc-marketplace', 'coc-vimtex', 'coc-markdown-preview-enhanced'] 

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Do not save backup files.
set nobackup

" Cursor line
:autocmd InsertEnter,InsertLeave * set cul!

" Vim commentary for cpp file
:autocmd FileType cpp setlocal commentstring=//\ %s
:autocmd FileType hpp setlocal commentstring=//\ %s

"Show buffer in airline 
set showtabline=2

"Shift arrow remappings
set keymodel=startsel

" Sort imports for python
let g:vim_isort_python_version = 'python3'
let g:vim_isort_map = '<C-i>'

" Map scroll commands
nnoremap <c-b> <c-u>
nnoremap <c-f> <c-d>

" Smart indent
set smartindent

" Key remappings
command WQ wq
command Wq wq
command W w
command Q q
command Nt NvimTreeToggle
command St SyntasticToggleMode
command Bt belowright split |terminal
nnoremap gr gT
nnoremap <C-A-l> :call CocAction('format')<CR>
nnoremap <C-A-o> :Isort<CR>
tnoremap <Esc> <C-\><C-n>

" Foldable setup
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

" Ignore capital letters during search.
set ignorecase

" PEP8 ruler
set colorcolumn=80

" UTF-8 Support
set encoding=utf-8

" Set the line number
set number relativenumber
set nu rnu

" ==================== lazygit.nvim ====================
noremap <c-g> :LazyGit<CR>
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
let g:lazygit_floating_window_boarder_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
let g:lazygit_use_neovim_remote = 1 " for neovim-remote support

" Use system clipboard
set clipboard+=unnamedplus

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Speedup ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

" Syntastic check
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_pylint_post_args="--max-line-length=80"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_cpp_checkers = ['clang_tidy']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_clang_tidy_args = '-checks=*'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Custom functions
" diff two files in new vertical split
function! DiffClipboard()
	let ft=&ft
	vertical new
	setlocal bufhidden=wipe buftype=nofile nobuflisted noswapfile
	:1put
	silent 0d_
	diffthis
	setlocal nomodifiable
	execute "set ft=" . ft
	wincmd p
	diffthis
endfunction
command! DiffClipboard call DiffClipboard()

" Vimtex setup
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" FZF lua setup
nnoremap <c-P> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <c-s-B> <cmd>lua require('fzf-lua').buffers()<CR>
nnoremap <c-f> <cmd>lua require('fzf-lua').grep_project()<CR>
nnoremap <C-A-f> <cmd>lua require('fzf-lua').live_grep()<CR>

" Declare the list of themes.
Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim'
Plug 'navarasu/onedark.nvim'
Plug 'catppuccin/nvim'

" Declare the list of plugins.
Plug 'github/copilot.vim'
Plug 'will133/vim-dirdiff'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-fugitive'
Plug 'ibhagwan/fzf-lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'fisadev/vim-isort'
Plug 'vim-syntastic/syntastic'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'mg979/vim-visual-multi'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'folke/flash.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


call plug#end()


" Set the theme.
let g:onedark_config = {
			\ 'style': 'warmer',
			\}

" Nvim tree lua post processing
lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
view = {
	width = 35,
},
})

require('flash').setup({
  flash_on_start = true,
  modes = {
    char = {
      jump_labels = true
    }
  }
})

require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = { enable = true },
  indent = { enable = false }
}

require("ibl").setup{
  scope = { enabled = false },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("nvim-autopairs").setup {}

EOF

colorscheme onedark
" colorscheme carbonfox
