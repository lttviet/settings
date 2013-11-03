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
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-sensible'
Bundle 'wookiehangover/jshint.vim'
Bundle 'klen/python-mode'
Bundle 'bling/vim-airline'

filetype plugin indent on     " required!

" Personal configs

set colorcolumn=80

"Tab = 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

"Turn off Python folding
let g:pymode_folding=0

"Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"Powerline font
let g:airline_powerline_fonts = 1
