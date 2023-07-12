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

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Do not save backup files.
set nobackup

"Show buffer in airline 
set showtabline=2
" Sort imports for python
let g:vim_isort_python_version = 'python3'
let g:vim_isort_map = '<C-i>'

" Map FZF Commands
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nnoremap <silent> <C-P> :FzfFiles<CR>
nnoremap <silent> <C-B> :FzfBuffers<CR>

" Key remappings
command WQ wq
command Wq wq
command W w
command Q q
command Ag FzfAg
command Nt NvimTreeToggle
command Bt belowright split |terminal
nnoremap gr gT
nnoremap <C-A-l> :Autoformat<CR>
nnoremap <C-A-o> :Isort<CR>
tnoremap <Esc> <C-\><C-n>

" Ignore capital letters during search.
set ignorecase

" PEP8 ruler
set colorcolumn=80

" UTF-8 Support
set encoding=utf-8

set number relativenumber
set nu rnu

" Use system clipboard
set clipboard+=unnamedplus

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Python syntax highlighting
let g:python_highlight_all = 1

" Cpp syntax highlighting
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_simple_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" Speedup ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

" Airline symnbol setup
let g:airline_symbols = {}
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' C'
let g:airline_symbols.linenr = ' L'

" Syntastic check
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

" Airline setup
function! AirlineInit()
	" first define a new part for modified
	call airline#parts#define('modified', {
				\ 'raw': '%m',
				\ 'accent': 'red',
				\ })

	" then override the default layout for section c with your new part
	let g:airline_section_c = airline#section#create(['%<', '%f', 'modified', ' ', 'readonly'])
endfunction
autocmd VimEnter * call AirlineInit()

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'kh3phr3n/python-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'fisadev/vim-isort'
Plug 'vim-autoformat/vim-autoformat'
Plug 'vim-syntastic/syntastic'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

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
EOF

colorscheme onedark
" colorscheme carbonfox
