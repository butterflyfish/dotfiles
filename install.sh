#/bin/sh

ln -sf $PWD/tmux.conf ~/.tmux.conf

(
cd terminfo
for info in *; do
	tic $info
done
)

