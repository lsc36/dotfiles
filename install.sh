#!/bin/sh
repo_root=`realpath $(dirname $0)`

git_prompt_sh=$repo_root/dot/git-prompt.sh
if [ ! -f "$git_prompt_sh" ]; then
	echo "Downloading git-prompt.sh"
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > $git_prompt_sh
fi

if [ ! -f ~/.vim/autoload/plug.vim ]; then
	echo "Downloading vim-plug"
	mkdir -p ~/.vim/autoload
	curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.vim/autoload/plug.vim
fi

for i in `ls $repo_root/dot`; do
	src=$repo_root/dot/$i
	dst=~/.$i
	[ -h "$dst" ] && rm $dst
	[ -f "$dst" ] && echo "Moving $dst to $dst.old" && mv $dst $dst.old
	echo "Symlink $dst -> $src"
	ln -s $src $dst
done

echo "Installing vim plugins"
vim -c PlugUpdate
