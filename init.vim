if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'Lokaltog/vim-easymotion'
Plug 'Valloric/MatchTagAlways'
Plug 'morhetz/gruvbox'
Plug 'vimwiki/vimwiki'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'}
Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : 'NERDTreeToggle' }

Plug 'fatih/vim-go'

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

"map esc to escape in terminal mode
tnoremap <Esc> <C-\><C-n>

"python3 syntastic
let g:syntastic_python_python_exec = '/usr/bin/python3'

"go to previous buffer then delete last buffer
nnoremap <Leader>q :bp<cr>:bd #<cr>

"vimwiki
let g:vimwiki_list = [{'path': '~/Repo/vimwiki'}]

"go
au BufNewFile,BufRead *.go setlocal ts=8 sw=8 sts=8
