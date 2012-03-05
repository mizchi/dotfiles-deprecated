alias vim="/usr/local/Cellar/vim/7.3/bin/vim"
alias reload="source ~/.zshrc"
source $HOME/perl5/perlbrew/etc/bashrc

path=($path ~/bin)
path=($path ~/android-tools/tools)
path=($path ~/android-tools/platform-tools)
path=($path /usr/local/Cellar/python/2.7/bin)
path=($path /usr/texbin)
# path=($path /usr/local/lib/ruby/gems/1.9.1/gems/gist-2.0.4/bin)
path=(/Applications/phantomjs.app/Contents/MacOS/ $path)

export ANDROID_SDK_HOME=/Users/mzi/android-tools
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH
# export PYTHONPATH="/usr/local/lib/python2.6.6/site-packages/:$PYTHONPATH"
export PYTHONPATH=${PYTHONPATH}:/usr/local/Cellar/python/2.7.2/lib/python2.7/site-packages/:/usr/local/google_appengine:/usr/local/google_appengine/lib/antlr3:/usr/local/google_appengine/lib/django:/usr/local/google_appengine/lib/webob:/usr/local/google_appengine/lib/yaml/lib

# export NODE_PATH=$HOME/.node_libraries:$PATH
export PATH=$HOME/bin:$PATH
export MANPATH=$HOME/share/man:$MANPATH
path=(/usr/local/Cellar/ruby/1.9.2-p180/bin/ $path)

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=/usr/local/bin:/usr/local/bin:/Users/mzi/.nodebrew/current/bin:/usr/local/Cellar/ruby/1.9.2-p180/bin/:/Users/mzi/bin:/Applications/phantomjs.app/Contents/MacOS/:/Users/mzi/perl5/perlbrew/bin:/Users/mzi/perl5/perlbrew/perls/perl-5.10.1/bin:/opt/local/bin:/opt/local/sbin:/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin:/bin/:/sbin/:/usr/bin:/usr/local/sbin:/usr/sbin:/Users/mzi/android-tools/tools:/Users/mzi/android-tools/platform-tools:/usr/local/Cellar/python/2.7/bin:/usr/texbin:/Users/mzi/.rvm/bin

# rvm use 1.9.3
