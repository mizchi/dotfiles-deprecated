# VHOME=~/Dropbox/vroot

# source ~/Dropbox/vroot/.zshrc
source ~/.zsh/env.zsh
source ~/.zsh/option.zsh
source ~/.zsh/function.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/tmux.zsh
source ~/.zsh/complete.zsh
source ~/.zsh/term.compat.zsh
alias rake='noglob rake'
alias gg='git grep'
alias javac="javac -encoding UTF-8"
export PATH=$HOME/.nodebrew/current/bin:$PATH
nodebrew use v0.8
alias s='git status'
alias m='git checkout master'
