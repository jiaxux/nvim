" Disable compatibility with vi which can cause unexpected issues
set nocompatible

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
nmap <silent> gd :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <silent> gv :vsp<CR><Plug>(coc-definition)

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Do not save backup files.
set nobackup

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
command Ag :FzfAg
command Bt  :belowright split |terminal  
nnoremap gr gT
tnoremap <Esc> <C-\><C-n>

" Ignore capital letters during search.
set ignorecase

" PEP8 ruler
set colorcolumn=120

" UTF-8 Support
set encoding=utf-8

set number relativenumber
set nu rnu

" Use system clipboard
set clipboard=unnamed

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" NERDTree setting
let g:NERDTreeWinSize=120

" Python syntax highlighting
let g:python_highlight_all = 1

" Cpp syntax highlighting
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_member_highlight = 1

" Speedup ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*

" Auto open NERDTree
"au VimEnter *  NERDTree
let g:NERDTreeWinSize=40

" Airline symnbol setup
let g:airline_symbols = {}
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = 'c'
let g:airline_symbols.linenr = 'l'
" Syntastic check
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_pylint_post_args="--max-line-length=120"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Declare the list of themes.
Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim'

" Declare the list of plugins.
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim'
Plug 'github/copilot.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'vim-python/python-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'

call plug#end()
colorscheme carbonfox
