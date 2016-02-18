#/bin/sh

# Tmux's configuration file
ln -sf $PWD/tmux.conf ~/.tmux.conf

# https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/
# install terminfo that support italic font
# and they are used by iTerm and Tmux etc
# Note if you do SSH, environment may be passed on the remote and it will probable don't know
# this terminal. A possible solution on the local host is to alias ssh
#     alias ssh="TERM=xterm-256color ssh"
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

(
echo "Install zsh prompt pure"
cd ~/.oh-my-zsh/custom
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh > pure.zsh-theme
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh > async.zsh
)

# download Minimalist Vim Plugin Manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo install/update minimalist Vim plugin manager

# Neovim/Vim's config file and plugins
echo "make links for Vim/Neovim's configuration"
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -sf ~/.vim $XDG_CONFIG_HOME/nvim
ln -sf $PWD/vimrc $XDG_CONFIG_HOME/nvim/init.vim
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vimrc.plug ~/.vimrc.plug

echo "start Vim/Neovim to install plugins"
$(type nvim > /dev/null) && nvim +PlugInstall +qall || vim +PlugInstall +qall
