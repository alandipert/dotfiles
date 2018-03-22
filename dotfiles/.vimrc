set number
syntax on

colorscheme koehler
hi FoldColumn ctermbg=Black ctermfg=Yellow
hi Statement  ctermfg=Black

"tabs are spaces (2 of them)
set tabstop=2
set shiftwidth=2
set expandtab
set cindent
set smartindent
set autoindent

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

filetype plugin indent on
