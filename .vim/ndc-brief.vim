" cbrief.vim, fix and addons to brief.vim
" Nicholas Christopoulos (nereus@freemail.gr), 2012 .. 2021

" F10: command-line
inoremap <F10> <C-O>:

" search
inoremap <silent> <A-s> <C-O>/
inoremap <silent> <C-S> <C-O>?

" search next
inoremap <silent> <A-f> <C-O>n

" search next backward
inoremap <silent> <C-F> <C-O>N

" Search and replace from the current cursor position
inoremap <silent> <A-t> <F6>

" Display buffer list
inoremap <A-b> <C-O>:buffers<CR>

" Paste scrab buffer contents to current cursor position.
" Vim register 'a' is used as the scrap buffer
inoremap <silent> <C-V> <C-O>"ap

" Copy marked text to scrap.
inoremap <silent> <C-C> <C-O>"ayy
vnoremap <silent> <C-C> "ay

" Cut line or mark to scrap buffer.
inoremap <silent> <C-X> <C-O>"add
vnoremap <silent> <C-X> "ax

