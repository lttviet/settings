set nocompatible               " be iMproved, required
filetype off                   " required!

set rtp+=~/.nvim/bundle/Vundle.vim
call vundle#begin('~/.nvim/bundle')

Plugin 'gmarik/Vundle.vim'

" original repos on github
Plugin 'tpope/vim-sensible'
Plugin 'Raimondi/delimitMate'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/MatchTagAlways'
Plugin 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on     " required!

syntax on
set hlsearch
set background=dark
colorscheme gruvbox

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
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

"Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"Airline
let g:airline_powerline_fonts = 1
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

"YCM
let g:ycm_global_ycm_extra_conf = '~/.nvim/.ycm_extra_conf.py'
