export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

export EDITOR="nvim"
export VISUAL="nvim"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

export CARGO_HOME=$HOME/.local/cargo

export PATH=$PATH:$HOME/.local/share/solana/install/active_release/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/jdk-17.0.2/bin

# added by third party packages
