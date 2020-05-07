let mapleader = "\<space>"
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>x :wq<cr>
nnoremap <leader>! :q!<cr>
nnoremap <leader>u :UndotreeToggle<cr>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader> <Plug>(easymotion-prefix)
nnoremap <leader><space> :Files<CR>

if !isdirectory($HOME . "/.config/nvim/_undodir")
    call mkdir($HOME . "/.config/nvim/_undodir", "p")
endif

set backspace=indent,eol,start
set number relativenumber
set undofile
set undodir=~/.config/nvim/_undodir
set mouse=n
set ignorecase
set smartcase
set lazyredraw
set hidden

command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap ; :

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
call plug#end()
