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
" set smarttab

" Search options
set hlsearch
set ignorecase
set incsearch
set smartcase

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


" Plugins
call plug#begin()

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ggreer/the_silver_searcher'
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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

    " colorschemes
    Plug 'srcery-colors/srcery-vim'
    Plug 'pacokwon/onedarkpaco.vim'
    Plug 'bluz71/vim-moonfly-colors'
    Plug 'sainnhe/sonokai'
    Plug 'joshdick/onedark.vim'
    Plug 'yassinebridi/vim-purpura'
    Plug 'lifepillar/vim-wwdc16-theme'
    Plug 'tckmn/hotdog.vim'
    Plug 'rakr/vim-one'
    Plug 'arcticicestudio/nord-vim'
    Plug 'sonph/onehalf'
    Plug 'rafi/awesome-vim-colorschemes'

    " VimWiki
    " Plug 'vimwiki/vimwiki'

    " Python
    Plug 'dense-analysis/ale'
    Plug 'pixelneo/vim-python-docstring'
    Plug 'davidhalter/jedi-vim'

    " Prettifier
    Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'markdown', 'python'] }
call plug#end()

colorscheme sonokai

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
let g:airline_theme='sonokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 1
" let g:airline_left_alt_sep = ''
let g:airline_left_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''

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

" Line lengths
au BufRead,BufNewFile *.rst setlocal textwidth=90
au BufRead,BufNewFile *.py setlocal textwidth=120
au BufRead,BufNewFile *.md setlocal textwidth=100

" Tab lengths
au BufRead,BufNewFile *.md setlocal tabstop=2

" Autocompletion
set wildmenu
set wildmode=list:longest
