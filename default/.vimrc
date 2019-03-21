syntax on
colorscheme koehler
filetype plugin indent on

" Highlight trailing whitespace
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set autoindent
set colorcolumn=80
set cursorline
set expandtab
set guifont=Source_Code_Pro:h14
set guioptions-=L
set guioptions-=T
set guioptions-=m
set guioptions-=r
set number
set ruler
set scrolloff=5
set shiftwidth=2
set smartindent
set tabstop=2

if has("gui_running")
  " Disable bell
  set vb t_vb=
endif

if has("win32")
  set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
endif

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

function! JsBeautify()
  let save_pos = getpos(".")
  execute ":w"
  call system(printf("js-beautify -r -f '%s'", expand('%:p')))
  execute ":e"
  call setpos(".", save_pos)
endfunction

function! FillParagraph()
  let save_pos = getpos(".")
  execute 'normal vipgq'
  call setpos(".", save_pos)
endfunction

let mapleader = " "
nnoremap <leader>;; :s/\v(.)$/\=submatch(1)==';' ? '' : submatch(1).';'<CR>
nnoremap <leader><S-Tab> :bprevious!<CR>
nnoremap <leader><Tab> :bnext!<CR>
nnoremap <leader>D :bp\|bd! #<CR>
nnoremap <leader>d :bp\|bd #<CR>
nnoremap <leader>fp :call FillParagraph()<CR>
nnoremap <leader>jsb :call JsBeautify()<CR>
nnoremap <leader>p :b#<CR>
nnoremap <leader>sw :set wrap linebreak nolist<CR>
nnoremap <leader>tws :call TrimWhitespace()<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>o :execute 'edit' fnameescape(substitute(@+, '.$', '', ''))<CR>

if has("win32")
  nnoremap <leader>m :call libcallnr("gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
endif

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal complete+=k
  autocmd FileType markdown setlocal spell
augroup END
