set wildmenu               " コマンド補完を強化
set wildchar=<tab>         " コマンド補完を開始するキー
set wildmode=list:full     " リスト表示，最長マッチ
set history=1000           " コマンド・検索パターンの履歴数
set complete+=k            " 補完に辞書ファイル追加
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>
source ~/dotfiles/.vimrc.completion.neocomplcache

" Alignを日本語環境で使用するための設定
let g:Align_xstrlen = 3

let NERDSpaceDelims = 1
let NERDShutUp=1

nnoremap <silent> <Space>id :<C-u>IndentGuidesToggle<Enter>
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 4
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
if 'dark' == &background
    hi IndentGuidesOdd  ctermbg=black
    hi IndentGuidesEven ctermbg=darkgrey
else
    hi IndentGuidesOdd  ctermbg=white
    hi IndentGuidesEven ctermbg=lightgrey
endif

let g:quickrun_config = {}
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'


"------------------------------------
" neocomplecache.vim
"------------------------------------
" AutoComplPopを無効にする
let g:acp_enableAtStartup = 0
" NeoComplCacheを有効にする
let g:neocomplcache_enable_at_startup = 1
" 補完が自動で開始される文字数
let g:neocomplcache_auto_completion_start_length = 3
" smarrt case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1
" camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_camel_case_completion = 1
" _(アンダーバー)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1
" シンタックスをキャッシュするときの最小文字長を3に
let g:neocomplcache_min_syntax_length = 3
" neocomplcacheを自動的にロックするバッファ名のパターン
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scala' : $HOME.'/.vim/bundle/vim-scala/dict/scala.dict',
    \ 'java' : $HOME.'/.vim/dict/java.dict',
    \ 'c' : $HOME.'/.vim/dict/c.dict',
    \ 'cpp' : $HOME.'/.vim/dict/cpp.dict',
    \ 'coffee' : $HOME.'/.vim/dict/coffee.dict',
    \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
    \ 'ocaml' : $HOME.'/.vim/dict/ocaml.dict',
    \ 'perl' : $HOME.'/.vim/dict/perl.dict',
    \ 'php' : $HOME.'/.vim/dict/php.dict',
    \ 'scheme' : $HOME.'/.vim/dict/scheme.dict',
    \ 'vm' : $HOME.'/.vim/dict/vim.dict'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" ユーザー定義スニペット保存ディレクトリ
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" スニペット
imap <C-y> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" 補完を選択しpopupを閉じる
" inoremap <expr><C-y> neocomplcache#close_popup()
" 補完をキャンセルしpopupを閉じる
" inoremap <expr><C-e> neocomplcache#cancel_popup()
" TABで補完できるようにする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" undo
inoremap <expr><C-g>     neocomplcache#undo_completion()
" 補完候補の共通部分までを補完する
inoremap <expr><C-s> neocomplcache#complete_common_string()
" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" C-kを押すと行末まで削除
" inoremap <C-k> <C-o>D
" C-nでneocomplcache補完
inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
" C-pでkeyword補完
inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
" 補完候補が出ていたら確定、なければ改行
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_omni_complete()

" buffer開いたらneoconでcache
autocmd BufReadPost,BufEnter,BufWritePost :NeoComplCacheCachingBuffer <buffer>

" FileType毎のOmni補完を設定
autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c          setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" autocmd FileType ruby let g:neocomplcache_source_disable = {
  " \ 'include_complete' : 1,
  " \ 'omni_complete' : 1
" \ }
" autocmd FileType ruby let g:neocomplcache_source_disable = {
  " \ 'include_complete' : 1
" \ }

"インクルードパスの指定
let g:neocomplcache_include_paths = {
  \ 'cpp'  : '.,/opt/local/include/gcc46/c++,/opt/local/include,/usr/include',
  \ 'c'    : '.,/usr/include',
  \ 'ruby' : '.,$HOME/.rvm/rubies/**/lib/ruby/1.8/',
  \ }
"インクルード文のパターンを指定
let g:neocomplcache_include_patterns = {
  \ 'cpp' : '^\s*#\s*include',
  \ 'ruby' : '^\s*require',
  \ 'perl' : '^\s*use',
  \ }
"インクルード先のファイル名の解析パターン
let g:neocomplcache_include_exprs = {
  \ 'ruby' : substitute(v:fname,'::','/','g')
  \ }
" ファイルを探す際に、この値を末尾に追加したファイルも探す。
let g:neocomplcache_include_suffixes = {
  \ 'ruby' : '.rb',
  \ 'haskell' : '.hs'
  \ }

let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
autocmd BufNewFile,BufRead *.coffee set filetype=coffee


let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"
"" indent guides
"augroup indentguides
"    autocmd!
"    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=64
"    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=128
"augroup END

colorscheme molokai
set ts=2 sw=2 et
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
