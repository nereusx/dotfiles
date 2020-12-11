" cbrief.vim, fix and addons to brief.vim
" Nicholas Christopoulos (nereus@freemail.gr), 2012 .. 2021

" F10: command-line
inoremap <F10> <C-O>:

" search next
inoremap <silent> <A-f> <C-O>n

" search backward
inoremap <silent> <C-S> <C-O>N

" Display buffer list
inoremap <A-b> <C-O>:buffers<CR>
