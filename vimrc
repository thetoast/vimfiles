colorscheme liquidcarbon
syntax on
filetype plugin indent on

" enable pathogen
call pathogen#infect()

" Set Variables {{{
set nu " line numbers
set gfn=ProggyClean " awesome font

" some tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" show 5 linues above/below cursor
set scrolloff=5

" set statusline
set laststatus=2
set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %l,%c%V/%L\ (%P)\ [%O:%02B]

set winminheight=0 " for window rolodexing

" set some backup stuff
set backupdir=~/.vimbackups//
set directory=~/.vimbackups//
set undodir=~/.vimbackups//

" persisent undo
set undofile

" spell language
set spelllang=en_us

" remove complete preview window
set completeopt-=preview
"}}}

" Key Mappings {{{
let mapleader=";"

" quick escape
ino jj <Esc>
cno jj <Esc>

" for window rolodexing
nno <Leader>j <C-w>j<C-w>_
nno <Leader>k <C-w>k<C-w>_

" remove highlighted searches
nno <Leader>n :noh

" spellmode
nno <silent> <Leader>s :setlocal spell!<CR>
"}}}

" Autocommands {{{
au BufWritePost *.tex :call system('latex -quiet ' . bufname('%'))
" }}}

" Plugin Settings {{{

" SuperTab
let g:SuperTabDefaultCompletionType='context'
" }}}

" vim:fdm=marker:
