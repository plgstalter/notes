syntax on

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'davidhalter/jedi-vim'
call plug#end()

set backspace=indent,eol,start

filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()

set number
imap <c-d> <esc>ddi
imap <c-w> <esc>:w<CR>i
let mapleader = ","
let maplocalleader = "\\"

:nnoremap <leader>ev :split $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

:iabbrev @@ pierrelouisgstalter67@gmail.com
:iabbrev ccopy © 2021 Pierre-Louis Gstalter
:iabbrev ssig -- <cr>Pierre-Louis Gstalter<cr>Élève de deuxième année aux Mines de Paris<cr>

autocmd FileType python call s:python_abbrevations()

function! s:python_abbrevations()
	iabbrev test test_python
endfunction

autocmd FileType html call s:html_abbrevations()

function! s:html_abbrevations()
	iabbrev DOCT DOCTYPE html>
	iabbrev html html><cr></html><esc>O
	iabbrev head head><cr></head><esc>O
	iabbrev body body><cr></body><esc>O
endfunction

autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call s:md_abbrevations()

function! s:md_abbrevations()
	iabbrev \R \mathbb R
	iabbrev \N \mathbb N
	iabbrev lrb llbracket\rrbracket<esc>9hi
	iabbrev dsum displaystyle\sum
	iabbrev dprod displaystyle\prod
	iabbrev dint displaystyle\int
endfunction
