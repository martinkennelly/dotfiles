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

set runtimepath^=~/.vim/bundle/ctrlp.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'valloric/YouCompleteMe'
Plugin 'joe-skb7/cscope-maps'
Plugin 'bogado/file-line'
Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plugin 'jeaye/color_coded'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'tomtom/tcomment_vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'godlygeek/tabular'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'sbdchd/neoformat'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kracejic/snippetinabox.vim'

Plugin 'joereynolds/gtags-scope'
Plugin 'sheerun/vim-polyglot'
Plugin 'rhysd/devdocs.vim'
Plugin 'tpope/vim-eunuch'

call vundle#end()

filetype plugin indent on

"============= AIRLINE ================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '_'
let g:airline_left_alt_sep = '_'
let g:airline_right_sep = '_'
let g:airline_right_alt_sep = '_'
let g:airline_symbols.branch = '_'
let g:airline_symbols.readonly = '_'
let g:airline_symbols.linenr = '_'

"=============== NERDTREE ================

"=============== Color coded =============
let g:color_coded_enabled = 1
let g:color_coded_filetypes = ['c', 'cpp', 'objc']

"=============== CTRL P ==================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'some_bad_symbolic_links',
	\ }


"======= YCM ========
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '%'
let g:ycm_warning_symbol = '%'
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
nnoremap <leader>yj :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yi :YcmCompleter GoToImplementationElseDeclaration<CR>
nnoremap <leader>yt :YcmCompleter GetTypeImprecise<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>ys :YcmDiags<CR>
nnoremap <leader>yD ::YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>yR :YcmRestartServer<CR>

"======= Tagbar ====
let g:tagbar_case_insensitive = 1
let g:tagbar_indent = 1
let g:tagbar_map_showproto = "r"
let g:tagbar_map_togglefold = "<space>"
let g:tagbar_sort = 0


"====== Functions ========

fu! SaveSession(fname)
	silent execute 'NERDTreeClose'
	silent execute 'TagbarClose'
	execute 'mksession! . getcwd() . "/" . a:fname'
endfunction

fu! RestoreSession(fname)
	execute 'NERDTreeClose'
	execute 'TagbarClose'

	silent execute 'bufdo bd'
		if filereadable(getcwd(), "/" . a:fname)
		execute 'so ' . getcwd() . "/" . a:fname
			if bufexists(1)
				for l in range(1, bufnr('$'))
					if bufwinnr(l) == -1
						exec 'sbuffer ' . l
					endif
				endfor
			end if
		endif
	syntax on
	execute 'TagbarToggle'
	execute 'NERDTreeToggle'
	execute 'wincmd l'
endfunction

if has('persistent_undo')
    call system('mkdir ~/.vim/undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif


"====== Commands ==========
command Quit call SaveSession(".session.vim") <bar> qa
command SaveSession call SaveSession(".session.vim")
command RestoreSession call RestoreSession(".session.vim")

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END
let &path.="src/"
execute pathogen#infect()
call pathogen#helptags()

nmap <Home> ^
nmap <End> $
nmap \q :nohlsearch<CR>
nnoremap <esc><esc> :silent! nohls<cr>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
nnoremap <silent> < :bp!<CR>
nnoremap <silent> > :bn!<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" Fast indentation changes
nmap <leader>t1 :set expandtab tabstop=1 shiftwidth=1 softtabstop=1<CR>
nmap <leader>T1 :set noexpandtab tabstop=1 shiftwidth=1 softtabstop=1<CR>
nmap <leader>t2 :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <leader>T2 :set noexpandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap <leader>t4 :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>T4 :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap <leader>t6 :set expandtab tabstop=6 shiftwidth=6 softtabstop=6<CR>
nmap <leader>T6 :set noexpandtab tabstop=6 shiftwidth=6 softtabstop=6<CR>
nmap <leader>t8 :set expandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>
nmap <leader>T8 :set noexpandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>

let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Python specific
au BufRead *.py
     \ set tabstop=4
     \ set softtabstop=4
     \ set shiftwidth=4
     \ set textwidth=79
     \ set expandtab
     \ set autoindent
     \ set fileformat=unix
