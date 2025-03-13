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
nnoremap <Space> '
vnoremap <Space> '

nnoremap mq mQ
vnoremap mq mQ

nnoremap mw mW
vnoremap mw mW

nnoremap me mE
vnoremap me mE

nnoremap mr mR
vnoremap mr mR

nmap <Space>q <Space>Q
vmap <Space>q <Space>Q

nmap <Space>w <Space>W
vmap <Space>w <Space>W

nmap <Space>e <Space>E
vmap <Space>e <Space>E

nmap <Space>r <Space>R
vmap <Space>r <Space>R

" Custom binds
nnoremap <Leader>r :set relativenumber!<CR>

" Clipboard binds
vnoremap Y "+y
vnoremap P "+p
nnoremap P "+p

" Disable special numeric format
set nrformats=