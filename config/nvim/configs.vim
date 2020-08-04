
let mapleader = "\<space>"
let g:startify_change_to_dir = 0
let g:airline_powerline_fonts = 1
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:EasyMotion_smartcase = 1
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:NERDSpaceDelims = 1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.DS_Store$', '\.git$']
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
let g:coc_global_extensions = [
 \  'coc-eslint',
 \  'coc-json',
 \  'coc-prettier',
 \  'coc-tsserver',
 \  ]


if !isdirectory($HOME . "/.config/nvim/undo-dir")
    call mkdir($HOME . "/.config/nvim/undo-dir", "p")
endif
set undodir=~/.config/nvim/undo-dir

set backspace=indent,eol,start
set number relativenumber
set undofile
set mouse=n
set ignorecase
set smartcase
set lazyredraw
set hidden
set notimeout
set smartcase
set incsearch


" ================== Coc settings =====================
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=yes

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}