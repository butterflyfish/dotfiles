#/bin/sh

# Tmux's configuration file
ln -sf $PWD/tmux.conf ~/.tmux.conf

# install terminfo that support italic font
# and they are used by iTerm and Tmux etc
(
cd terminfo
for info in *; do
	tic $info
done
)

