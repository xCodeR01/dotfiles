# dotfiles


`git clone --recursive https://github.com/xCodeR01/dotfiles.git ~/dotfiles`

make sure stow is installed `sudo apt install stow` or `sudo dnf install stow`

`cd ~/dotfiles`

remove any zsh related file from home like `.zshrc` `.zprofile` etc. and then run
`stow zsh`

remove any nvim related file from ~/.config/nvim and then run
`stow nvim` 

to stow `git`, `compton`, `featherpad` and `clipit` configs, run
`stow others`
