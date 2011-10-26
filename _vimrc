set nocompatible
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"---------------- come on baby --------

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp
set nobomb
language english
let &termencoding=&encoding
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
endif


syntax on
filetype on

" 行号
set number
set ruler

" 状态行
set stl=\ [file]\ %F%m%r%h%y[%{&fileencoding}]\ [Line]%l/%L\ %=\[%P]
set ls=2
set wildmenu

" tab 和缩进
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" 快捷键
map tn :tabnext<cr>
map tp :tabprevious<cr>
map tc :tabclose<cr>
map <C-t> :tabnew<cr>
" 缓存区
map bf :BufExplorer<CR>
" 文件树
map td :NERDTree<CR>

" 自动切换到当前目录
set autochdir

set showcmd


if has('win32')
	au GUIEnter * simalt ~x

	au! bufwritepost hosts !start cmd /C ipconfig /flushdns<cr>
    	command -nargs=0 Vimrc :tabnew $VIM/_vimrc
    	command -nargs=0 Hosts :tabnew c:\windows\system32\drivers\etc\hosts
	
endif

" 自动加载
if has("autocmd")
    filetype plugin indent on

    " 括号自动补全
    func AutoClose()
        :inoremap ( ()<ESC>i
        :inoremap " ""<ESC>i
        :inoremap ' ''<ESC>i
        :inoremap { {}<ESC>i
        :inoremap [ []<ESC>i
        :inoremap ) <c-r>=ClosePair(')')<CR>
        :inoremap } <c-r>=ClosePair('}')<CR>
        :inoremap ] <c-r>=ClosePair(']')<CR>
    endf
    func ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf

    au FileType php,c,python,javascript,html exe AutoClose()

    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=80
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END

endif

" GVIM 下的配置
if has('gui_running')
    " 高亮光标所在行
    set cursorline
    " 只显示菜单和右侧滚动条
    set guioptions=c
    " 字体配置
    exec 'set guifont='.iconv('Consolas', &enc, 'gbk').':h13:cANSI'
    " exec 'set guifontwide='.iconv('YaHei', &enc, 'gbk').':h11'
    " 界面
    colorscheme hotoo_manuscript 
   
endif



