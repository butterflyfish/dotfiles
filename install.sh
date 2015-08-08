#/bin/sh

# Tmux's configuration file
ln -sf $PWD/tmux.conf ~/.tmux.conf

# install terminfo that support italic font
# and they are used by iTerm and Tmux etc
(
cd terminfo
for info in *; do
	tic $info
	echo compile terminfo $info
done
)

# install fonts
# iTerm2 and Vim use the fonts
./fonts/install.sh

# install oh-my-zsh[https://github.com/robbyrussell/oh-my-zsh]
[ -d  ~/.oh-my-zsh/.git ] || sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $PWD/zshrc ~/.zshrc
echo "make link for zshrc"

# download Minimalist Vim Plugin Manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo install/update minimalist Vim plugin manager

# Neovim/Vim's config file and plugins
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vimrc ~/.nvimrc
ln -sf $PWD/vimrc.plug ~/.vimrc.plug
echo "make links for Vim/Neovim's configuration"
echo "start vim to install plugins"
vim +PlugInstall +qall
