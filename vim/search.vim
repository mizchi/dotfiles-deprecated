
"-------------------------------------------------------------------------------
"" 検索設定 Search
"-------------------------------------------------------------------------------
"set wrapscan   " 最後まで検索したら先頭へ戻る
"set ignorecase " 大文字小文字無視
"set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
"set incsearch  " インクリメンタルサーチ
"set hlsearch   " 検索文字をハイライト
""Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
vnoremap /r "xy;%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'
"
nnoremap <C-i>  :<C-u>help<Space>
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
" nnoremap <silent> <C-g><C-r> :<C-u>Rgrep<Space><C-r><C-w> *<Enter><CR>
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = '*.bak *~'
