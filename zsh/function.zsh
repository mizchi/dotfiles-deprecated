bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

_Z_CMD=j
source ~/.zsh/modules/z/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

