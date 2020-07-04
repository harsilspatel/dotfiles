autocmd vimenter * colorscheme gruvbox

let mapleader = "\<space>"
let g:hardtime_default_on = 1

nnoremap <leader>w :w<CR>
nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>
nnoremap <leader>! :q!<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
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
set tabstop=4
set shiftwidth=4
set expandtab
set notimeout

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap ; :

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-surround'
call plug#end()
