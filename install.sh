#/bin/sh

# Tmux's configuration file
ln -sf $PWD/tmux.conf ~/.tmux.conf

# https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/
# update terminfo to support italic font supported by iTerm Tmux etc
# Test: echo `tput sitm`italics`tput ritm`
infocmp $TERM |sed  's|$|sitm=\\E[3m, ritm=\\E[23m,|' > $TERM.ti
tic $TERM.ti

# fix ctrl-h does not work
# https://github.com/neovim/neovim/wiki/FAQ
infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
tic $TERM.ti

rm  $TERM.ti

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

# A command-line fuzzy finder
[  -d  ~/.fzf ] || {
echo Clone fuzzy finder fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
}

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
$(type nvim 2&1 > /dev/null) && nvim +PlugInstall +qall || vim +PlugInstall +qall
