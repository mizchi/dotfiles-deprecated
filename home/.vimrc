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
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'derekwyatt/vim-scala'
filetype plugin indent on
NeoBundleCheck

set syntax=on
syntax enable
set tabstop=4
set shiftwidth=4
set splitbelow
set splitright
set expandtab
set whichwrap=b,s,h,l,<,>,[,]
set fileformat=unix
set fileformats=unix,dos
set noshellslash

nnoremap ,s :source %<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" theme
colorscheme monokai
hi CtrlPLinePre guifg=red ctermfg=red

let g:quickrun_config = {}
nnoremap <C-r> :QuickRun<CR>
let g:quickrun_config = {
   \   'scala': {
   \       'command': 'scala',
   \       'exec': "%c %s"
   \   },
   \   'coffee': {
   \       'command': 'coffee'
   \   },
   \}
