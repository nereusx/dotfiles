#!/bin/sh

#mkdir ~/.vim/autoload
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

if [ ! -d ~/.vim/pack/downloads/opt ]; then
	mkdir -p ~/.vim/pack/downloads/opt
fi
cd ~/.vim/pack/downloads/opt || exit 1

vid=1

echo "=== download/update vim plugins ==="
list=""
#list="$list borland"
#list="$list bufselect"
#list="$list scratch"
#list="$list taglist"
#list="$list brief fileselect mru lsp"
for b in $list; do
	printf "\033[1m%02d. %s:\033[0m " $vid "$b"
	if [ -d $b/.git ]; then
		cd $b
		git pull
		cd ..
	else
		rm -rf $b
		git clone https://github.com/yegappan/$b
	fi
	vid=$(($vid+1))
done

# python scripts
#list="$list https://github.com/dense-analysis/ale"
#list="$list https://github.com/ycm-core/YouCompleteMe"
#list="$list https://github.com/aitjcize/cppman"
#list="$list https://github.com/theniceboy/vim-calc"
#list="$list https://github.com/Shougo/unite.vim"
#list="$list https://github.com/xolox/vim-easytags"
#list="$list https://github.com/xolox/vim-misc"
#list="$list https://github.com/vim-syntastic/syntastic"

list=""
list="$list https://github.com/junegunn/vim-plug"
#list="$list https://github.com/preservim/nerdtree"
#list="$list https://github.com/vimwiki/vimwiki"
#list="$list https://github.com/bling/vim-bufferline"
list="$list https://github.com/vim-airline/vim-airline"
#list="$list https://github.com/frazrepo/vim-rainbow"
list="$list https://github.com/skywind3000/vim-quickui"
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
#list="$list https://github.com/mcchrish/nnn.vim"
#list="$list https://github.com/voldikss/vim-floaterm"
#list="$list https://github.com/tpope/vim-obsession"
#list="$list https://github.com/arcticicestudio/nord-vim"
#list="$list https://github.com/prabirshrestha/quickpick.vim"
#list="$list https://github.com/jeetsukumaran/vim-buffergator"
#list="$list https://github.com/wincent/command-t"
list="$list https://github.com/francoiscabrol/ranger.vim"
list="$list https://github.com/rbgrouleff/bclose.vim"
for b in $list; do
	p=$(basename $b)
	printf "\033[1m%02d. %s:\033[0m " $vid "$p"
	if [ -d $p/.git ]; then
		cd $p
		git pull
		cd ..
	else
		rm -rf $p
		git clone $b
	fi
	vid=$(($vid+1))
done

#echo "=== apply patches ==="
#d2u_list="borland/colors/borland.vim"
#if command -v dos2unix > /dev/null 2>&1; then
#	for p in $d2u_list; do
#		dos2unix $p
#	done
#fi
echo "=== done ==="
