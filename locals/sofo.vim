" Local Vim configuration for Sonic Foundry

"set gfn=ProggyCleanTT:h12
set encoding=utf-8
set gfn=Anonymice\ Powerline:h12

au BufNewFile,BufRead sconstruct set ft=python
au BufNewFile,BufRead sconscript set ft=python
au BufNewFile,BufRead *.as set ft=actionscript | set makeprg=scons
au BufNewFile,BufRead *.mxml set ft=mxml | set makeprg=scons

call add(g:pathogen_disabled, 'jslint.vim')
"call add(g:pathogen_disabled, 'supertab')

" vim: ft=vim
