# dotfiles


`git clone --recursive https://github.com/xCodeR01/dotfiles.git ~/Dotfiles`

make sure stow is installed `sudo apt install stow` or `sudo dnf install stow`

`cd ~/Dotfiles`

remove any zsh related file from home like `.zshrc`, `.zprofile` etc. and then run
`stow zsh`

remove any nvim related file from `~/.config/nvim` and `~/.config/local/share/nvim`  and then run
`stow nvim` 

to stow `git`, `compton`, `featherpad` etc., configs, run
`stow others`
