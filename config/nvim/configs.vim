
let mapleader = '\<space>'

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'

let g:ackprg = 'ag --nogroup --nocolor --column'
let g:airline_powerline_fonts = 1
let g:EasyMotion_smartcase = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:NERDSpaceDelims = 1
let g:NERDTreeIgnore = ['\.DS_Store$', '\.git$']
let g:NERDTreeShowHidden = 1
let g:startify_change_to_dir = 0

let g:coc_global_extensions = [
 \  'coc-eslint',
 \  'coc-json',
 \  'coc-prettier',
 \  'coc-python',
 \  'coc-tsserver',
 \  ]


for s:dir_name in ['swap', 'undo']
    let s:dir_path = $HOME . '/.config/nvim/' . s:dir_name
    if !isdirectory(s:dir_path)
        call mkdir(s:dir_path, 'p')
    endif
endfor

set backspace=indent,eol,start
set directory=~/.config/nvim/swap//
set hidden
set ignorecase
set incsearch
set lazyredraw
set mouse=n
set notimeout
set number relativenumber
set smartcase
set undodir=~/.config/nvim/undo//
set undofile


" ================== vim test ========================
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

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
set statusline^=%{coc#status()}%{get(s:,'coc_current_function','')}
