# dotfiles

Michael's configuration files for power tools
* [Vim](http://www.vim.org)/[Neovim](http://neovim.io/)
* [Zsh](http://www.zsh.org)
* [Tmux](http://tmux.github.io)

## Zsh

zsh is configured with help of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
Taking MAC OS as an example to show *How to let zsh as default shell on Mac OS ?*

```sh
brew install zsh
chsh -s /usr/local/bin/zsh $USER
echo /usr/local/bin/zsh >> /etc/shells
```
