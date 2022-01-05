# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/masacaai/.zshrc'

autoload -Uz compinit
compinit

fpath+=$HOME/.config/zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

/home/masacaai/.scripts/zsh/crunch
export PATH=/home/masacaai/.local/bin:$PATH
export PATH=/home/masacaai/.scripts/maim:$PATH

# End of lines added by compinstall
