set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-sensible'
Bundle 'wookiehangover/jshint.vim'
Bundle 'klen/python-mode'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'

filetype plugin indent on     " required!

" Personal configs

set hidden
set colorcolumn=80

"Tab = 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Turn off Python folding
let g:pymode_folding=0

"Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"Powerline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1
