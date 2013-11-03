execute pathogen#infect()
syntax on
filetype plugin indent on
set t_Co=256

"Line number
"set nu
set colorcolumn=80

"Tab = 2 spaces
filetype indent on
set tabstop=2
set shiftwidth=2
set expandtab

"Turn off Python folding
let g:pymode_folding=0

"Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"Powerline font
let g:airline_powerline_fonts = 1
