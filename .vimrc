" Interface
syntax on
set wildmenu
set number
set laststatus=2
set visualbell
set wrap

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

" Leader key
let mapleader = " "
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>
