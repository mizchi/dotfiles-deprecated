set nocompatible  " be iMproved
filetype off      " required!

"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"
"Bundle 'gmarik/vundle'
"Bundle 'kchmck/vim-scoffee-script'
"set rtp+=~/.vim/bundle/vundle/vim-coffee-script
"Bundle 'kien/ctrlp.vim'
"set rtp+=~/.vim/bundle/vundle/ctrlp.vim

filetype plugin indent on
syntax on

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

