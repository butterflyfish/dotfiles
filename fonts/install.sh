#!/bin/sh

cd $(dirname $0)

if [[ `uname` == 'Darwin' ]]; then # Mac OS

  font_dir="$HOME/Library/Fonts"
  cp *.ttf $font_dir

elif [[ `which fc-cache` ]]; then # linux

  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
  cp *.ttf $font_dir
  # Reset font cache
  fc-cache -f $font_dir
fi

echo "All Powerline fonts installed to $font_dir"
