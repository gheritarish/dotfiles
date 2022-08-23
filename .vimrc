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

" User interface options
set laststatus=2
set ruler
set noerrorbells
set title
set splitright " New tab open on the right
set splitbelow " New tab open below
set cmdheight=2 " Two lines for commands

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
noremap <C-w>< :vertical<CR>:resize -5<CR>
noremap <C-w>> :vertical<CR>:resize +5<CR>

" Terminal: 20 rows, called with leader-t
nnoremap <leader>t :term ++rows=20<CR>

" Tabs
nnoremap <C-p> :tabprev<CR>
nnoremap <C-n> :tabnext<CR>
nnoremap <leader>s :tabnew<CR>

" Plugins
call plug#begin()

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ggreer/the_silver_searcher'
    "Plug 'preservim/nerdtree'
    "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'tpope/vim-fugitive'
    Plug 'preservim/nerdcommenter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    " Plug 'jiangmiao/auto-pairs'

    " Open several files in tabs
    Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
    " Plug 'ryanoasis/vim-devicons' Icons without colours
    Plug 'akinsho/bufferline.nvim'

    " Brackets
    Plug 'LunarWatcher/auto-pairs'
    Plug 'frazrepo/vim-rainbow'

    " colorschemes
    "Plug 'srcery-colors/srcery-vim'
    "Plug 'pacokwon/onedarkpaco.vim'
    "Plug 'bluz71/vim-moonfly-colors'
    Plug 'sainnhe/sonokai'
    Plug 'jnurmine/Zenburn'
    " Plug 'joshdick/onedark.vim'
    "Plug 'yassinebridi/vim-purpura'
    "Plug 'lifepillar/vim-wwdc16-theme'
    "Plug 'tckmn/hotdog.vim'
    "Plug 'rakr/vim-one'
    "Plug 'arcticicestudio/nord-vim'
    "Plug 'sonph/onehalf'
    "Plug 'rafi/awesome-vim-colorschemes'
    Plug 'morhetz/gruvbox'

    " VimWiki
    " Plug 'vimwiki/vimwiki'

    " Python
    Plug 'dense-analysis/ale'
    Plug 'pixelneo/vim-python-docstring'
    Plug 'davidhalter/jedi-vim'
    Plug 'ycm-core/YouCompleteMe'

    " Prettifier
    Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'markdown', 'python'] }

    " Justfile
    Plug 'NoahTheDuke/vim-just'
call plug#end()

" auto-pairs
let g:AutoPairsCompatibleMaps = 0

" let g:sonokai_theme = 'andromeda'
set background=dark
colorscheme gruvbox
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
" let g:airline_left_alt_sep = ''
" let g:airline_left_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline#extensions#tabline#fnamemod = ":t"
" let g:gruvbox_contrast_dark = 'hard'

" fzf.vim
let g:fzf_colors= {
      \  'border': ['fg', 'Type' ],
      \  'gutter': ['fg', 'Type' ] }

" vim-jsx-pretty
hi jsxAttrib ctermfg=3*
hi jsxComponentName ctermfg=4*
hi jsxTagName ctermfg=4*
hi jsxPunct ctermfg=3*
hi jsObjectProp ctermfg=3*
hi jsxCloseString ctermfg=3*

" typescript-vim
let g:typescript_indent_disable = 1
hi javaScriptLineComment ctermfg=4*

" vim-go
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_types = 1
let g:go_highlight_function_calls = 1

" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#print_width = '100'

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Ale config
let g:ale_fix_on_save = 1
let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8']}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'python': ['isort'],
\ 'rust': ['rustfmt'],
\ 'go': ['gofmt']
\ }

let g:python_style = 'google'

" Jedi config
let g:pymode_rope = 0
let g:jedi#completion_command = "<tab>"

" Line lengths
au BufRead,BufNewFile *.rst setlocal textwidth=90
au BufRead,BufNewFile *.py setlocal textwidth=120
au BufRead,BufNewFile *.md setlocal textwidth=100

" Tab lengths
au BufRead,BufNewFile *.md setlocal tabstop=2
au BufRead,BufNewFile *.md setlocal shiftwidth=2
au BufRead,BufNewFile *.rst setlocal tabstop=4
au BufRead,BufNewFile *.sql setlocal tabstop=4

" Brackets config
au FileType python,rst,sql,c,ts,html,make,groovy call rainbow#load()

" Jenkinsfile
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy

" Autocompletion
set wildmenu

set omnifunc=syntaxcomplete#Complete


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
