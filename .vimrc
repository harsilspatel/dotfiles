set number

let @q = ":let @\" = expand('%:r')\<CR>"
let @z = "/jobName: \<CR>3wyi\""
let @e = ":g/\"\<C-r>0\/normal cs\"`\<CR>"
" let @r = ":%s/\<C-r>0/${jobName}/g\<CR>"
" let @w = "/exports.run\<CR>O\<Esc>I\/\/ \<Esc>pjoconst jobName = item.job\<Esc>"
let @r = ":%s/\<C-r>0/${EVENT_NAME}/g\<CR>"
let @w = "/exports.run\<CR>O\<Esc>Iconst EVENT_NAME = \"\";\<Esc>hhp"

" let @d = "@e@r@w/jobName:\<CR>wc$,\<Esc>:wq\<CR>"
let @d = "@e@r@w:wq\<CR>"
let @a = "@q@d"
let @s = "@z@d"

let @w = "Gobleh\<Esc>:wq"

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
call plug#end()
