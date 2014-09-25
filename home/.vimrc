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
NeoBundle 'https://github.com/leafgarland/typescript-vim.git'
NeoBundle 'https://github.com/clausreinke/typescript-tools.git'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'gkz/vim-ls'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'jdonaldson/vaxe'

augroup InsertHook
  autocmd!
  autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
  autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

filetype plugin indent on
NeoBundleCheck

set syntax=on
syntax enable
set tabstop=2
set shiftwidth=2
set cindent
set whichwrap=b,s,h,l,<,>,[,]
set fileformat=unix
set showcmd
set nofoldenable
set fileformats=unix,dos
set noshellslash
set ambiwidth=double
set guioptions-=r
set guioptions-=m
set guioptions-=T
set nowritebackup
set nobackup
set noswapfile
set autoread
set backspace=indent,eol,start
set vb t_vb=
if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=236 guibg=Cyan
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

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
   \   'livescript': {
   \       'command': 'livescript'
   \   },
   \   'ls': {
   \       'command': 'livescript'
   \   },
   \}

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_camel_case_completion = 1
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions',
  \ 'c' : $DOTVIM.'/dict/c-eglibc.dict',
  \ 'objc' : $DOTVIM.'/dict/objectivec.dict',
  \ 'ruby' : $DOTVIM.'/dict/ruby.dict',
  \ 'perl' : $DOTVIM.'/dict/perl.dict',
  \ 'css' : $DOTVIM.'/dict/css.dict',
  \ 'javascript' : $DOTVIM.'/dict/javascript.dict',
  \ 'coffee' : $DOTVIM.'/dict/javascript.dict',
  \ 'actionscript' : $DOTVIM.'/dict/actionscript.dict'
  \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" dot: completion.
" inoremap <expr> . pumvisible() ? neocomplete#smart_close_popup().".\<C-X>\<C-O>\<C-P>" : ".\<C-X>\<C-O>\<C-P>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup()."\<Space>" : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType cpp set omnifunc=cppcomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType typescript setlocal omnifunc=TSScompleteFunc
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd BufNewFile,BufRead *.purs set filetype=haskell

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*'
let g:neocomplete#sources#omni#input_patterns.typescript = '.*'
let g:neocomplete#sources#omni#input_patterns.javascript = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'"

" For clang_complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
"let g:clang_use_library = 1
"autocmd vimenter * NERDTree
nmap <silent> <C-e>  :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
"let g:NERDTreeMouseMode=0
let g:NERDTreeWinPos = "right"

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap t :Unite file_rec<CR>

let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap ; <Plug>NERDCommenterToggle
vmap ; <Plug>NERDCommenterToggle

autocmd Filetype haskell setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype typescript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype coffee setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype livescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype ls setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype lisp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" 検索などで飛んだらそこを真ん中に
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nmap G Gzz
" CTRL-hjklでウィンドウ移動
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

imap <C-p> <Up>
imap <C-n> <Down>
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-a> <ESC><S-i>

set pastetoggle=<F2>
let g:quickrun_config['haxe'] = {
			\ 'command' : 'haxe'
			\ , 'args' : '-x'
			\ , 'cmdopt' : '-main ' . "%{HaxeClssName(expand(\"%S:t:r\"))}"
			\ , 'exec' : "%c %o %a %s:p"
			\ }
 
function! HaxeClssName(word)
  return substitute(a:word, '^\v.*\ze\.hx', '\u&', '')
endfunction
