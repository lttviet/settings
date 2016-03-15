call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'morhetz/gruvbox'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'}

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : 'NERDTreeToggle' }

Plug 'tpope/vim-rails', { 'for' : 'ruby' }

Plug 'elixir-lang/vim-elixir'

call plug#end()

syntax on
set background=dark
colorscheme gruvbox

" Add $ to the end of change
set cpoptions+=$

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
