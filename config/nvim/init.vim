
source ~/.dotfiles/config/nvim/maps.vim
source ~/.dotfiles/config/nvim/configs.vim
source ~/.dotfiles/config/nvim/commands.vim
source ~/.dotfiles/config/nvim/functions.vim

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'mbbill/undotree'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-test/vim-test'

call plug#end()
