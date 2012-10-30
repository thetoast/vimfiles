colorscheme liquidcarbon
syntax on
filetype plugin indent on

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

" make backspace behave normally
set backspace=indent,eol,start

" search settings
set hlsearch
set incsearch

" don't switch buffers in windows
set switchbuf=useopen

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
nno <Leader>n :noh<CR>

" spellmode
nno <silent> <Leader>s :setlocal spell!<CR>

" making things easier (PUN!)
nno <Leader>m :make<CR><C-w>_
nno <Leader>h :cp<CR><C-w>_:copen<CR>z10<CR><C-w><C-p>
nno <Leader>l :cn<CR><C-w>_:copen<CR>z10<CR><C-w><C-p>
"}}}

" Autocommands {{{

" auto compile latex files
au BufWritePost *.tex :call system('latex -quiet ' . bufname('%'))

" show quickfix window after make
au QuickFixCmdPost make cw
au QuickFixCmdPost make call MarkErrors()

" highlight cursor line in current window
au BufEnter * setlocal cursorline " hack so that vim startup and splitting still highlights
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

" }}}

" Plugin Settings {{{

" SuperTab
let g:SuperTabDefaultCompletionType='context'
" }}}

sign define qferr text=>> texthl=Error

function MarkErrors()
    let list = getqflist()
    let errno = 1

    sign unplace *

    let bufs_initted = {}

    for li in list
        if li.valid
            if !has_key(bufs_initted, li.bufnr)
                call setbufvar(li.bufnr, 'errs', {})
                let bufs_initted[li.bufnr] = 1
            endif

            let errs = getbufvar(li.bufnr, 'errs')
            let errs[li.lnum] = li.text
            exec "sign place " . errno " line=" . li.lnum " name=qferr buffer=" . li.bufnr
        endif
    endfor
endfunction

function ShowError(num)
    if exists('b:errs')
       if exists('b:errs[a:num]')
           echo b:errs[a:num]
       else
           echo
       endif
    else
        echo
    endif
endfunc
au CursorMoved * call ShowError(line('.'))

"
" declare pathogen disabled list
let g:pathogen_disabled = []

" load local configs
if filereadable($HOME . '/_vimlocal')
    exec "source " . $HOME . "/_vimlocal"
elseif filereadable($HOME . '/.vimlocal')
    exec "source " . $HOME . "/.vimlocal"
endif

" enable pathogen
call pathogen#infect()


" vim:fdm=marker:
