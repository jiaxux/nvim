" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Do not save backup files.
set nobackup

" Ignore capital letters during search.
set ignorecase

" UTF-8 Support
set encoding=utf-8

set number relativenumber
set nu rnu

" Use system clipboard
set clipboard=unnamed

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'github/copilot.vim'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme dracula
