# dotfiles

Michael's configuration files for power tools
* [Vim](http://www.vim.org)/[Neovim](http://neovim.io/)
* [Zsh](http://www.zsh.org)
* [Tmux](http://tmux.github.io)

## How to use ?

If you don't install these power tools, please install them. On MAC OS, it's recommended
to use [brew](http://brew.sh)

```sh
git clone
cd dotfiles
./install.sh
```

## Zsh

zsh is configured with help of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
Taking MAC OS as an example to show *How to let zsh as default shell on Mac OS ?*

```sh
chsh -s /usr/local/bin/zsh $USER
sudo echo /usr/local/bin/zsh >> /etc/shells
```

## [iTerm](https://iterm2.com)

iTerm is my favority terminal emulator on MAC OS X. It have wonderful features, e.g.

* Mouseless Copy
* Trigger
* Captured Output
* Autocomplete
* Paste History & Advanced Paste

My profiles change set:

* Text page: use *Anonymice Powerline* as Font and Non-ASCII Font
* Terminal: Report Terminal  Type is *xterm-256color-italic*
* Advanced -> Trigger
	* Regular Expression: *^([a-zA-Z0-9+/.-]+):([0-9]+):[0-9]+: (?:error|warning):*
	* Action: Capture Output
	* Parameters: *echo :e +\2 \1*
* colors presets: [guvbox](https://github.com/morhetz/gruvbox-generalized/tree/master/iterm2), Solarized Dark(builtin)

How to reset settings to default ?

```sh
defaults delete com.googlecode.iterm2
```


