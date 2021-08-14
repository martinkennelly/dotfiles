syntax on
set showmatch
set hlsearch
set incsearch
set exrc
set secure
set encoding=utf-8
set number
set nowrap
set autoread
set lazyredraw
set history=100
set expandtab
set backspace=indent,eol,start
set scrolloff=5
set noswapfile
set ruler
set showcmd
set title
set showmode
set visualbell
set cursorline
set smartcase
set ignorecase
set incsearch
set virtualedit=onemore
set autoindent
set smartindent
set smarttab
set softtabstop=4
set shiftwidth=2
set wildmenu
set wildignore+=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn,*/cm/log/**,tags,*.jpg,*.png,*.jpeg,*.png,*.mesh,build*/**,build/**,*.sublime-workspace,*.svg,build2/**,build3/**
set confirm
set mouse=v
set previewheight=8
set cscopetag
set tags=./tags;/
set splitbelow
set splitright
set spellfile=~/.vim/spell/spell.misc.utf-8.add
set undolevels=800
set tabpagemax=20

command! Spellen :setlocal spell spelllang=en_us
command! Spellcs :setlocal spell spelllang=cs
command! Spellnone :setlocal nospell


let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235
let &colorcolumn="80,".join(range(120,999),",")

highlight Extrawhitespace ctermbg=red guibg=red
match Extrawhitespace /\s\+$/

autocmd BufWinEnter * match Extrawhitespace /\s\+$/
autocmd InsertEnter * match Extrawhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match Extrawhitespace /\s\+$/
autocmd BufWinLeave * match Extrawhitespace /\s\+$/

augroup filetypedetect
    au BufRead,BufNewFile *.log set filetype=log
    au BufReadPost,BufNewFile *.conf set ft=conf
    au BufReadPost,BufNewFile *.xml set tabstop=4
    au BufReadPost,BufNewFile *.crt set ft=crt
augroup END

execute pathogen#infect()
syntax on
filetype plugin indent on

" NERD Tree
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" map a specific key or shortcut to open NERDTree
map <F2> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" change default arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" End Nerd Tree
