" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'codable/diffreview'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-jade'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'moll/vim-node'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'rhysd/vim-clang-format'
Plug 'roryokane/detectindent'
Plug 'steffanc/cscopemaps.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/php.vim-html-enhanced'
Plug 'vim-scripts/winmanager'
" 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"only static checker, replaced by ALE
"Plug 'vim-syntastic/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'skywind3000/quickmenu.vim'
" 确定插件仓库中的分支或者 tag
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"(re)generate tag files as you work while staying completely out of your way
Plug 'ludovicchabant/vim-gutentags'
"异步模式, not blocked by existing build/run process
Plug 'skywind3000/asyncrun.vim'
" Initialize plugin system
"
" relative numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" provides mappings to easily delete, change and add such surroundings
" in pairs.
Plug 'tpope/vim-surround'
" sort in Vim using text objects and motions.
Plug 'christoomey/vim-sort-motion'
"adds a new operator (command that takes a text object or motion to act on)
"for titlecasing text.
Plug 'christoomey/vim-titlecase'
"provides vim mappings for copying / pasting text to the os specific clipboard.
Plug 'christoomey/vim-system-copy'
Plug 'scrooloose/nerdcommenter'
"A plugin of NERDTree showing git status flags
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

filetype plugin indent on    " required

" Syntax
syntax on

" Color scheme
set background=dark
colorscheme solarized
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

let mapleader="\<Space>"

" Line length bar
set colorcolumn=120
set cursorline
set cursorcolumn

" Share clipboard with OS
set clipboard=unnamed

" Better tab
set shiftwidth=4
set tabstop=4
set expandtab

" Tell bad spaces
:match Error /\s\+$/

" Always show status bar
set laststatus=2

" Detect indent
augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END

" Generate meta files for cscope and ctags
nmap <C-\>m :!cscope -Rqb<CR>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" Setup clang format
let g:clang_format#command='clang-format-6.0'
let g:clang_format#auto_format=1
let g:clang_format#enable_fallback_style=0

" Setup YouCompleteMe
set encoding=utf-8
nnoremap <leader>gt :YcmCompleter GoTo<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'


" Backspace fix
set backspace=indent,eol,start

" The Silver Searcher
let g:ackprg = 'ag --vimgrep'
nnoremap <leader>k :Ack <cword><CR>

" Backspace fix
 set backspace=indent,eol,start

let g:tagbar_width=60
nmap <C-t> :TagbarToggle<CR>

" rename as `.tags` and recursive find .tags up to parent path if no in current directory
set tags=./.tags;,.tags

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


" Config AsyncRun
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" 编译单文件
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>


nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

" enable the mouse (in xterm or GUI).
set mouse=a

" Configure Titlecase
let g:titlecase_map_keys = 0
"Titlecase the region defined by a text object or motion
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
" Titlecase the entire line
nmap <leader>gT <Plug>TitlecaseLine

"open a NerdTree automatically when vim starts up
"autocmd vimenter * NERDTree
" open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Nerd commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
" let g:NERDDefaultAlign = 'left'
"
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
"
" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"
" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1
"
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
