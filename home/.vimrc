call pathogen#infect()
call pathogen#helptags()
set nocompatible
set shortmess+=atI
filetype plugin on
filetype plugin indent on
set laststatus=2
set hidden
set wildmenu
set wildmode=list:longest
set number

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

syntax on
syntax enable
set history=1000 "store lots of :cmdline history
inoremap <D-s> <ESC>:w<CR>
nnoremap <D-s> :w<CR>

" normal mode ########################################
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let mapleader = ","
nnoremap <leader>w <C-w>c
" toggle `set list` -- show/hide invisible characters
nmap <leader>li :set list!<CR>
nnoremap <leader>ln :set number!<CR>
nnoremap <leader>a :Ag -i 
nnoremap <leader>s :! 
nnoremap <leader>cd :lcd %:p:h<CR>
nnoremap <leader>t :TagbarOpenAutoClose<CR>
nnoremap <leader>d :NERDTreeFind<CR>
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b :BuffergatorToggle<CR>

" insert a blank line below while staying in Normal mode
nnoremap <silent> <C-CR> o<Esc>k

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable extended % matching
" The % key will switch between opening and closing brackets. By sourcing matchit.vim — a standard file in Vim installations for years — the key can also switch among e.g. if/elsif/else/end, between opening and closing XML tags, and more.
runtime macros/matchit.vim

" insert mode #######################################
inoremap <C-a> <Home>
inoremap <C-e> <End> 
inoremap <C-d> <Del>
" inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
" inoremap <C-l> <Right>

" command mode #######################################
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

set ignorecase 
set smartcase
set incsearch
" set hlsearch
nnoremap <silent> <C-c> <Esc>:nohl<CR><C-c>
nnoremap <silent> <Esc> :nohl<CR><Esc>

nnoremap / /\v
nnoremap ? ?\v
" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk

set scrolloff=5
vnoremap <space> :
nnoremap <space> :
set showcmd
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2

"------ appearance ------
colorscheme solarized
set guifont=Consolas:h16
set background=dark
set list
" set listchars=tab:▸\ ,eol:¬,trail:·
set listchars=tab:▸\ ,trail:·

" PowerLine
set noshowmode 
let g:Powerline_symbols = 'fancy'

let NERDTreeHijackNetrw = 1 
let NERDTreeMinimalUI=1

" nnoremap <c-p> :CtrlPMixed<cr>
 let g:ctrlp_map = '<c-p>'
 let g:ctrlp_cmd = 'CtrlPMixed'
 let g:ctrlp_show_hidden = 1
let g:ctrlp_max_height = 10
let g:ctrlp_max_files = 1000
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("k")':   ['<c-k>'],
      \ 'PrtSelectMove("j")':   ['<c-j>'],
      \ }
set wildignore+=.git/*,*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX

