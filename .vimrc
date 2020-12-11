set number
syntax on
set tabstop=4
set autoindent
if filereadable(expand('~/.vim/vimrc'))
	source ~/.vim/vimrc
endif
