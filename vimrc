colorscheme liquidcarbon
syntax on
filetype plugin indent on

" Set Variables {{{
set rnu " line numbers
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
"set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %l,%c%V/%L\ (%P)\ [%O:%02B]

" AIRLINE {{{
let g:airline_powerline_fonts = 1
" }}}

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

" auto compile PlantUML files
au BufWritePost *.uml :call job_start('plantuml -o img ' . bufname('%'))

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
let g:SuperTabDefaultCompletionType="<c-o>"

" UltiSnips
let g:UltiSnipsEditSplit='vertical'

" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3

" define completion keywords
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns['typescript'] = '[^. \t]\.\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns['javascript'] = '[^. \t]\.\%(\h\w*\)\?'

inoremap <expr><C-g>    neocomplcache#undo_completion()
inoremap <expr><C-l>    neocomplcache#complete_common_string()

" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"    return neocomplcache#smart_close_popup() . "\<CR>"
"endfunc

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript,typescript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

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

" Autoload any files which have a mode change {{{
function CheckFileChangedEvent()
    if v:fcs_reason == "mode"
        let v:fcs_choice = "reload"
    else
        let v:fcs_choice = "ask"
    endif
endfunction
au FileChangedShell * call CheckFileChangedEvent()
" }}}

" QuickSearch code {{{
let g:qs_mouse_mode = 0
high quickMatch1 guibg=orange guifg=black
high quickMatch2 guibg=green guifg=black
high quickMatch3 guibg=cyan guifg=black

function QuickSearchHighlight(word, alt, shift)
    let matchnum = 1

    if a:alt
        let matchnum = 2
    elseif a:shift
        let matchnum = 3
    endif

    execute matchnum . "match quickMatch" . matchnum . " /" . a:word . "/"
endfunc

function ToggleMouseMode()
    if g:qs_mouse_mode
        let g:qs_mouse_mode = 0
        set mouse=a
    else
        let g:qs_mouse_mode = 1
        set mouse=icn
    endif
endfunc

function ClearQuickSearch(...)
    if a:0
        execute a:1 . "match none"
    else
        match none
        2match none
        3match none
    endif
endfunc

nmap <2-LeftMouse> :call QuickSearchHighlight("<C-R><C-W>", 0, 0)<CR>
nmap <A-2-LeftMouse> :call QuickSearchHighlight("<C-R><C-W>", 1, 0)<CR>
nmap <S-2-LeftMouse> :call QuickSearchHighlight("<C-R><C-W>", 0, 1)<CR>
nmap <F12> :call ToggleMouseMode()<CR>
nmap <Esc><Esc> :call ClearQuickSearch()<CR>
nmap <Esc>1 :call ClearQuickSearch(1)<CR>
nmap <Esc>2 :call ClearQuickSearch(2)<CR>
nmap <Esc>3 :call ClearQuickSearch(3)<CR>
vmap <F11> "zy :call QuickSearchHighlight(@z, 0, 0)<CR>
vmap <A-F11> "zy :call QuickSearchHighlight(@z, 1, 0)<CR>
vmap <S-F11> "zy :call QuickSearchHighlight(@z, 0, 1)<CR>
" }}}

" Tabular auto tabling {{{
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
" }}}

" declare pathogen disabled list
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'jslint.vim')

" enable eslint syntastic checker
let g:syntastic_javascript_checkers = ['eslint']

" load local configs
if filereadable($HOME . '/_vimlocal')
    exec "source " . $HOME . "/_vimlocal"
elseif filereadable($HOME . '/.vimlocal')
    exec "source " . $HOME . "/.vimlocal"
endif

" load project config
if filereadable('.vimproj')
    source .vimproj
    augroup vimproj
    if (g:proj_show_nerdtree)
        au vimproj VimEnter * NERDTree
        au vimproj VimEnter * wincmd p
    endif
endif

" enable pathogen
call pathogen#infect()


" vim:fdm=marker:
