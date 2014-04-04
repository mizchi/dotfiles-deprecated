set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/homebrew/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
set PATH $HOME/homebrew/Cellar/s3cmd/1.0.1/libexec $PATH

set -x GOPATH $HOME/.go
set -x PKG_CONFIG_PATH $HOME/homebrew/Cellar/python3/3.3.4/Frameworks/Python.framework/Versions/3.3/lib/pkgconfig/

rbenv rehash >/dev/null ^&1

alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bes="bundle exec rspec"
alias g="git"
env opam config env
