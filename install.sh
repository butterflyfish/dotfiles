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
./fonts/install.sh

# install oh-my-zsh[https://github.com/robbyrussell/oh-my-zsh]
[ -d  ~/.oh-my-zsh/.git ] || sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $PWD/zshrc ~/.zshrc
echo "make link for zshrc"

