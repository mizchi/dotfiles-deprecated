set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# OPAM configuration
# . /Users/mizchi/.opam/opam-init/init.fish > /dev/null 2> /dev/null || true
alias b="bundle"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bes="bundle exec rspec"
alias g="git"
