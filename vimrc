filetype plugin on
filetype indent on
"setlocal spell spelllang=en

syntax on

set nu

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set winminheight=0 " for window rolodexing


" todo: get my windows machine's colorscheme synced up
colorscheme evening

" todo: get the proggyclean font running on my mac

" Key Mappings {{{
let mapleader=";"

" quick escape
ino jj <Esc>
cno jj <Esc>

" for window rolodexing
nno <Leader>j <C-w>j<C-w>_
nno <Leader>k <C-w>j<C-w>_
"}}}

" vim:fdm=marker:
