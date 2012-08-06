" Local Vim configuration for Sonic Foundry

set gfn=ProggyCleanTT:h12

au BufNewFile,BufRead sconstruct set ft=python
au BufNewFile,BufRead sconscript set ft=python
au BufNewFile,BufRead *.as set ft=actionscript | set makeprg=scons
au BufNewFile,BufRead *.mxml set ft=mxml | set makeprg=scons

" vim: ft=vim
