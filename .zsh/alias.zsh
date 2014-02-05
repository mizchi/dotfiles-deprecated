export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;34:ln=01;35:so=32:pi=33:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="gls --group-directories-first -Al --color=always"
alias la="gls --group-directories-first --color=always"
alias ll='ls -alF'

alias g=/usr/local/bin/git
alias e="vim"

alias ..='cd ..'
alias ...='cd ../..'
alias -- +='pushd .'
alias -- -='popd'

alias ta="tmux attach"
alias man='LANG=${LANG/en_US.UTF-8/en_US} command man'
alias grep='command grep -nH --color'

alias java="java -Dfile.encoding=utf-8"
alias javac="javac -J-Dfile.encoding=utf-8"
alias gosh="rlwrap -b '(){}[], #\";| ' gosh"

_replace (){
    grep -rl "$1" "$3" | xargs sed -i.bak "s/$1/$2/g"
}
alias pyserver="python -m SimpleHTTPServer "
