set shell=/bin/sh
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'git@github.com:thinca/vim-quickrun.git'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'derekwyatt/vim-scala'
"NeoBundle 'Valloric/YouCompleteMe' , {
"  \ 'build' : {
"  \     'unix' : './install.sh',
"  \    },
"  \ } 
filetype plugin indent on
NeoBundleCheck
set syntax=on
syntax enable


" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
colorscheme monokai
hi CtrlPLinePre guifg=red ctermfg=red

let g:quickrun_config = {}
nnoremap <C-r> :QuickRun<CR>
let g:quickrun_config['scala'] = {
      \   'outputter': 'browser'
      \ }


"タブ文字の長さ
set tabstop=4
set shiftwidth=4
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
set fileformat=unix
set fileformats=unix,dos
set noshellslash
let g:quickrun_config = {
   \   'scala': {
   \       'command': 'scala',
   \       'exec': "%c %s"
   \   },
   \   'coffee': {
   \       'command': 'coffee'
   \   },
   \}
"let g:quickrun_config={'*': {'split': ''}}
