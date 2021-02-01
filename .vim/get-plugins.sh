#!/bin/sh

# 
getrepo() {
	for b in $*; do
		p=$(basename $b)
		printf "\033[1m%02d. %s:\033[0m " $vid "$p"
		if [ -d $p/.git ]; then
			cd $p
			git pull
			cd ..
		else
			rm -rf $p
			git clone --depth 1 $b
		fi
		vid=$(($vid+1))
	done
	}

#
vid=1

case "$1" in
-c)	rm -rf ~/.vim/pack;;
esac

[ ! -d ~/.vim/pack/downloads/opt ] && mkdir -p ~/.vim/pack/downloads/opt
cd ~/.vim/pack/downloads/opt || exit 1

echo "=== download/update vim plugins ==="

list=""
list="$list https://github.com/sheerun/vim-polyglot"

#list="$list https://github.com/yegappan/borland"
#list="$list https://github.com/yegappan/bufselect"
#list="$list https://github.com/yegappan/scratch"
#list="$list https://github.com/yegappan/taglist"
#list="$list https://github.com/yegappan/brief
#list="$list https://github.com/yegappan/fileselect"
#list="$list https://github.com/yegappan/mru"
#list="$list https://github.com/yegappan/lsp"

#list="$list https://github.com/dense-analysis/ale"
#list="$list https://github.com/ycm-core/YouCompleteMe"
#list="$list https://github.com/aitjcize/cppman"
#list="$list https://github.com/theniceboy/vim-calc"
#list="$list https://github.com/Shougo/unite.vim"
#list="$list https://github.com/xolox/vim-easytags"
#list="$list https://github.com/xolox/vim-misc"
#list="$list https://github.com/vim-syntastic/syntastic"

list="$list https://github.com/junegunn/vim-plug"
#list="$list https://github.com/preservim/nerdtree"
#list="$list https://github.com/vimwiki/vimwiki"
#list="$list https://github.com/bling/vim-bufferline"
list="$list https://github.com/vim-airline/vim-airline"
#list="$list https://github.com/frazrepo/vim-rainbow"
#list="$list https://github.com/skywind3000/quickmenu.vim"
#list="$list https://github.com/entrez/reedline.vim"
#list="$list https://github.com/preservim/tagbar"
#list="$list https://github.com/kien/ctrlp.vim"
#list="$list https://github.com/Raimondi/delimitMate"
#list="$list https://github.com/powerman/vim-plugin-viewdoc"
#list="$list https://github.com/mileszs/ack.vim"
#list="$list https://github.com/ervandew/supertab"
#list="$list https://github.com/manasthakur/vim-commentor"
#list="$list https://github.com/natebosch/vim-lsc"
list="$list https://github.com/itchyny/lightline.vim"
#list="$list https://github.com/junegunn/fzf.vim"
#list="$list https://github.com/thaerkh/vim-workspace"
#list="$list https://github.com/farmergreg/vim-lastplace"
list="$list https://github.com/mcchrish/nnn.vim"
#list="$list https://github.com/voldikss/vim-floaterm"
#list="$list https://github.com/tpope/vim-obsession"
#list="$list https://github.com/arcticicestudio/nord-vim"
#list="$list https://github.com/prabirshrestha/quickpick.vim"
#list="$list https://github.com/jeetsukumaran/vim-buffergator"
#list="$list https://github.com/wincent/command-t"
#list="$list https://github.com/francoiscabrol/ranger.vim"
list="$list https://github.com/rbgrouleff/bclose.vim"
list="$list https://github.com/skywind3000/vim-quickui"
list="$list https://github.com/ptzz/lf.vim"
#list="$list https://github.com/tomtom/tcomment_vim"
#list="$list https://github.com/Yggdroot/indentLine.git"
#list="$list https://github.com/justinmk/vim-dirvish"

getrepo $list

echo "=== ndc stuff ==="
[ ! -d ~/.vim/pack/ndc/opt ] && mkdir -p ~/.vim/pack/ndc/opt
cd ~/.vim/pack/ndc/opt || exit 1

list=""
list="$list https://github.com/nereusx/vim-cbrief"

getrepo $list

echo "=== done ==="

