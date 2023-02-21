" Line umber
set number
" Wrap at world
set wrap linebreak nolist

" Activate mouse in vim
set mouse=a

" Filetype & syntax
filetype indent plugin on
syntax on

" Indent options
set autoindent
set expandtab	" convert tabs to space
set tabstop=4
set shiftwidth=4
" set smarttab

" Search options
set hlsearch
set ignorecase
set incsearch
set smartcase

set viewoptions=folds

" Folds
augroup remember_folds
    autocmd!
    autocmd BufWinLeave * silent! mkview
    autocmd BufWinEnter * silent! loadview
augroup END

augroup vimQuit
    autocmd ExitPre * silent! qa
augroup END

augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufWinEnter *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END


" Text rendering
set display+=lastline " to always show the last line of a paragraph
set linebreak
set cursorline
set scrolloff=5
set guicursor=n-c-v-i-sm-ci-ve-r-cr-o:block

" User interface options
set laststatus=2
set ruler
set noerrorbells
set title
set splitright " New tab open on the right
set splitbelow " New tab open below
set cmdheight=1 " Two lines for commands

" Automatically strip trailing spaces on buffer write
autocmd BufWritePre * :%s/\s\+$//e

" Change leader command
let mapleader = ','

" Bépo keyboard
" [HJKL] -> [TSRN]
" {tn} = left / right
noremap t h
noremap n l
" {sr} = down / up
noremap s j
noremap r k
" {SR} = down / up half-page
noremap S <C-D>
noremap R <C-U>
" {TN} = beginning / end of line
noremap T 0
noremap N $
" Manpage on $
noremap $ K
noremap <C-J> J

" [TSNR] -> [HJKL]
" {J} = jusqu'à
noremap j t
noremap J T
" {H} = replace
noremap h r
noremap H R
" {K} = substitute
noremap k s
noremap K S
" {L} = next / previous
noremap l n
noremap L N

" Remap window mode for bépo keyboard
" {tn} = left / right
noremap <C-w>t <C-w>h
noremap <C-w>n <C-w>l

" {sr} = down / up
noremap <C-w>s <C-w>j
noremap <C-w>r <C-w>k

" h => split
noremap <C-w>h <C-w>s

" j => left origin
noremap <C-w>j <C-w>t

" k => rotate
noremap <C-w>k <C-w>r

" l => new file
noremap <C-w>l <C-w>n

" Resize windows by 5 lines / columns
noremap <C-w>+ :resize +5<CR>
noremap <C-w>- :resize -5<CR>
noremap <C-w>< :vertical resize -5<CR>
noremap <C-w>> :vertical resize +5<CR>

" Terminal: 20 rows, called with leader-t
nnoremap <leader>t :sp term://zsh<CR>

" Tabs
nnoremap <C-p> :tabprev<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <leader>s :tabnew<CR>

" Git
nnoremap <leader>g :Workspace RightPanelToggle<CR>

" Plugins
call plug#begin()

    " Writing code
    Plug 'LunarWatcher/auto-pairs'
    Plug 'frazrepo/vim-rainbow'
    Plug 'preservim/nerdcommenter'

    " Open several files in tabs
    Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
    Plug 'akinsho/bufferline.nvim'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'jreybert/vimagit'

    " Python
    Plug 'pixelneo/vim-python-docstring'
    Plug 'SirVer/ultisnips'

    " Justfile
    Plug 'NoahTheDuke/vim-just'
call plug#end()

" auto-pairs
let g:AutoPairsCompatibleMaps = 0

let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_invert_selection = 0

let NERDTreeMinimalUI=1
autocmd BufEnter * if tabpagenr('$') == 1
      \ && winnr('$') == 1
      \ && exists('b:NERDTree')
      \ && b:NERDTree.isTabTree()
      \ | quit | endif

" vim-nerdtree-syntax-highlight
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1

let g:NERDTreeSyntaxEnabledExtensions = ['rb', 'ruby']

" vim-devicons
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = 'ﰆ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yml'] = ''

let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*vimrc.*'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.gitignore'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['package.lock.json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['node_modules'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['webpack\.'] = 'ﰩ'

let g:DevIconsEnableFoldersOpenClose = 1

" vim-airlines
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline_detect_spell = 0

" fzf.vim
let g:fzf_colors= {
      \  'border': ['fg', 'Type' ],
      \  'gutter': ['fg', 'Type' ] }

" Ale config
let g:ale_fix_on_save = 1
let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8']}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'python': ['isort', 'black'],
\ 'rust': ['rustfmt']
\ }

let g:python_style = 'google'

" Jedi config
let g:pymode_rope = 0
let g:jedi#completion_command = "<tab>"

" DIfferent types support
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=120
autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=100 spell spelllang=fr,en_gb
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=90 spell spelllang=fr,en_gb
autocmd FileType sql setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Brackets config
au FileType python,rst,sql,c,ts,html,make,groovy call rainbow#load()

" Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile* set filetype=groovy


" Snippets
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Arch global vimrc
"
" Added here for a manual vim configuration
"
" Use Vim defaults instead of 100% vi compatibility
" Avoid side-effects when nocompatible has already been set.
if &compatible
  set nocompatible
endif

set backspace=indent,eol,start
set ruler
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj

" Terminal Buffer
function! TerminalSettings()
    setlocal nonumber
    normal a
endfunction
augroup terminal
    autocmd!
    autocmd TermOpen * call TerminalSettings()
augroup END

" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'
" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif
