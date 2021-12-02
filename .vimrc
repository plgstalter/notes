" general scripts
syntax on
set backspace=indent,eol,start
set number
set ruler

let mapleader = ","
let maplocalleader = ";"


" plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'davidhalter/jedi-vim'
call plug#end()

""
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>" <esc>Bi"<esc>Wa"
nnoremap <leader>' <esc>Bi'<esc>Wa'
nnoremap <leader>f :call FoldColumnToggle()<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>
nnoremap <leader>z :call ZenModeToggle()<cr>
nmap <leader>m <Plug>MarkdownPreview

""
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

""
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>

function! ZenModeToggle()
	set number!
	set ruler!
endfunction

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! FoldColumnToggle()
    echom &foldcolumn
endfunction

" shortcuts
:iabbrev @@ pierrelouisgstalter67@gmail.com
:iabbrev ccopy © 2021 Pierre-Louis Gstalter
:iabbrev ssig -- <cr>Pierre-Louis Gstalter<cr>Élève de deuxième année aux Mines de Paris<cr>

" typo self-correction
:iabbrev onne one

" filetype specific commenting
:autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
:autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
:autocmd FileType html nnoremap <buffer> <localleader>c I<--<esc>A--><esc>
:autocmd FileType cpp nnoremap <buffer> <localleader>c I//<esc>


" Syntax Highlighting
filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS

" FileType specific scripting
autocmd FileType python call s:python_abbrevations()

function! s:python_abbrevations()
	iabbrev test test-py
	iabbrev if if :<left>
endfunction

autocmd FileType cpp call s:cpp_abbrevations()

function! s:cpp_abbrevations()
	iabbrev ret return
	iabbrev inc #include
	iabbrev ios <iostream>
	iabbrev main int main(int argc, char const *argv[]) { <cr> return 0; <cr> } <esc>kO
endfunction

autocmd FileType html call s:html_abbrevations()

function! s:html_abbrevations()
	iabbrev DOCT DOCTYPE html>
	iabbrev html html><cr></html><esc>O
	iabbrev head head><cr></head><esc>O
	iabbrev body body><cr></body><esc>O
	iabbrev div div><cr></div><esc>O
	iabbrev aa a href""></a><esc>5hi
endfunction

autocmd FileType markdown call s:md_tweaks()

function! s:md_tweaks()
	"write in Zen Mode
	call ZenModeToggle()

	" math abbreviations
	iabbrev \R \mathbb R
	iabbrev \N \mathbb N
	iabbrev \C \mathbb C
	iabbrev \Q \mathbb Q
	iabbrev \Z \mathbb Z
	iabbrev lrb \llbracket\rrbracket<esc>9hi
	iabbrev dsum \displaystyle\sum_{
	iabbrev dprod \displaystyle\prod_{
	iabbrev dint \displaystyle\int
	iabbrev syst \begin{cases}<cr>\end{cases}<esc>ldWO
	iabbrev mmax \underset{}{\max}\text{ }<esc>ldW14hi
	iabbrev mmin \underset{}{\min}\text{ }<esc>ldW14hi
	iabbrev enss \left\{\right\<esc>6hi
	iabbrev comp \mathcal O(
	iabbrev riar \rightarrow
	iabbrev lear \leftarrow
	iabbrev Riar \Rightarrow
	iabbrev Lear \Leftarrow
	iabbrev Lriar \Leftrightarrow
	iabbrev lrar \longrightarrow
	iabbrev esp \mathbb E\left[<esc>a
	iabbrev osim \overset\sim
	iabbrev msp \text{ }<esc>ls
	iabbrev ssup \underset{}{\sup}\text{ }<esc>ldW14hi
	iabbrev iinf \underset{}{\inf}\text{ }<esc>ldW14hi
	iabbrev eps \varepsilon   
	iabbrev pre< \preccurlyeq
	iabbrev suc> \succcurlyeq
	iabbrev o+ \oplus
	iabbrev ox \otimes

	" text abbreviations
	iabbrev iff if and only if
	iabbrev ofc of course

	" autocorrect
	iabbrev inn in
	iabbrev innfty infty

	" just in case the word inn is actually needed
	iabbrev _inn inn

	" auto complete
	inoremap $ $$<left>
	inoremap \{ \{\}<esc>hi
	inoremap \left\{ \left\{\right\}<esc>7hi
	inoremap \left( \left(\right)<esc>6hi
	inoremap \left[ \left[\right]<esc>6hi

	"highlight mathematic equations
	" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'
    "multiline math. Look for "$[anything][anything][anything]$"
    syn region multiline_math start=/\$/ end=/\$/

    " Actually highlight those regions.
    hi link math Statement
    hi link math_block Function
    hi link multiline_math Function

endfunction

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
