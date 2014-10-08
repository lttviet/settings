set nocompatible              " be iMproved, required
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" original repos on github
Plugin 'tpope/vim-sensible'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'tomasr/molokai'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on     " required!

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Add $ to the end of change
set cpoptions+=$

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,trail:-,eol:¬

set nobackup
set number
set hidden
set colorcolumn=80
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4

"Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
let g:airline#extensions#tabline#enabled = 1

"EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
"Replace default search
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"Line search
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
