syntax on
filetype off
set nocompatible
set ai "autoIndent
set background=dark
set sw=4 "shiftWidth
set ts=4 "tabstop
set ruler
set nu "number
set sc "showCommand
set incsearch "incremental search"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdTree'
Plugin 'bling/vim-airline'
Plugin 'pangloss/vim-javascript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/syntastic'

call vundle#end()

filetype  plugin indent on

"vim-airline
let g:airline#extensions#tabline#enabled = 1
" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts = 1





" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings fot UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
	\ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
	\ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
	\ 're!\\hyperref\[[^]]*',
	\ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
	\ 're!\\(include(only)?|input){[^}]*',
	\ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
	\ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
	\ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
	\ ]

" markdown folding
let g:vim_markdown_folding_disabled = 1


" syntastic config
set statusline+=%#warningmsg#

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

nnoremap <silent> <F12> :NERDTree<CR>


noremap <C-h> gT 
noremap <C-l> gt

map <F10> :call CompileRunGCC()<cr>
func! CompileRunGCC()
	exec "w"
	exec "!gcc % -o %<"
	exec "! ./%<"
endfunc

map <F9> :call CompileRunJava()<cr>
func! CompileRunJava()
	exec "w"
	exec "!javac %"
	exec "!java %<"
endfunc

nmap <F3> :call RunPython()<cr>
imap <F3> <ESC>:call RunPython()<cr>
func! RunPython()
	exec "w"
	exec "!python %"
endfunc

map <F5> :call CompileUploadArduino()<cr>
func! CompileUploadArduino()
	exec "w"
	exec " !/Applications/Arduino.app/Contents/MacOS/Arduino --upload $PWD/%"
endfunc

map <F2> :call RunLatex()<cr>
func! RunLatex()
	exec "w"
	exec "!pdflatex %"
	exec "!xdg-open %<.pdf"
endfunc

inoremap qq <Esc>
inoremap zz <Esc>zza
inoremap aa <Esc>la
inoremap AA <Esc>A
inoremap OO <Esc>o
inoremap ;; <Esc>:
noremap ;; :
inoremap [ []<ESC>i
inoremap {<cr> {<cr>}<ESC>ko
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
noremap = <c-w>+
noremap - <c-w>-
noremap , <c-w><
noremap . <c-w>>
