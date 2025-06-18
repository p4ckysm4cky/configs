" Interface
syntax on
set wildmenu
set number
set laststatus=2
set visualbell
set wrap
set relativenumber
set t_Co=16

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Navigation
noremap j gj
noremap k gk

noremap <S-h> gT
noremap <S-l> gt

noremap <S-j> 5gj
noremap <S-k> 5gk

noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" Mark navigation
nnoremap mq mQ
vnoremap mq mQ

nnoremap mw mW
vnoremap mw mW

nnoremap me mE
vnoremap me mE

nnoremap mr mR
vnoremap mr mR

nnoremap 'q 'Q
vnoremap 'q 'Q

nnoremap 'w 'W
vnoremap 'w 'W

nnoremap 'e 'E
vnoremap 'e 'E

nnoremap 'r 'R
vnoremap 'r 'R

" Custom binds
let mapleader = " "
nnoremap <Leader>r :set relativenumber!<CR>
nnoremap <leader>h :noh<CR>
nnoremap <leader>m :delm!<CR>
nnoremap <leader>M :delm A-Z<CR>

" Clipboard binds
vnoremap Y "+y
vnoremap P "+p
nnoremap P "+p

" Disable special numeric format
set nrformats=