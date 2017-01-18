syntax on
filetype off
set nocompatible
set ai "autoIndent
set smartindent
set background=dark
set sw=4 "shiftWidth
set ts=4 "tabstop
set ruler
set nu "number
set sc "showCommand
set expandtab "change tab to space
set incsearch "incremental search"
set history=200
set cursorline
set clipboard=unnamedplus
set completeopt-=preview
set autochdir
"set pastetoggle=<F2>

autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview

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
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'scrooloose/syntastic'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'NBUT-Developers/extra-instant-markdown'
Plugin 'tpope/vim-surround'
Plugin 'Yggdroot/indentLine'
Plugin 'plasticboy/vim-markdown'
call vundle#end()

filetype  plugin indent on

"vim-airline
let g:airline#extensions#tabline#enabled = 1
" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts = 1

"vim-instant-markdown
let g:instant_markdown_autostart = 0

"ranger
let g:ranger_open_new_tab = 1

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

" disable markdow conceal
let g:vim_markdown_conceal = 0


" syntastic config
set statusline+=%#warningmsg#
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python2.7'

nnoremap <silent> <F12> :NERDTreeToggle<CR>
inoremap <silent> <F12> <ESC>:NERDTreeToggle<CR>
map <F3> :call RunScript()<CR>
imap <F3> <ESC>:call RunScript()<CR>
func! RunScript(...)
	exec "w"
	if &filetype == "c"
		exec "!gcc % -o %< && ./%<"
	elseif &filetype == "cpp"
		exec "!g++ % -o %< && ./%<"
	elseif &filetype == "java"
		exec "!javac % && java %<"
	elseif &filetype == "python"
		exec "!python %"
	elseif &filetype == "plaintex"
		exec "!pandoc % -o %<.pdf --latex-engine=pdflatex"
		"exec "!pdflatex % --interaction=nonstopmode"
	elseif &filetype == "markdown"
		exec "InstantMarkdownPreview"
	elseif &filetype == "javascript"
		exec "!node %"
	elseif &filetype == "arduino"
		exec "!arduino --upload $PWD/%"
	elseif &filetype == "sh"
		exec "!sh %"
	elseif &filetype == "html"
		exec "!xdg-open %"
	endif
endfunc



noremap <C-v> :-1r!xclip -o<CR>
inoremap <C-v> <ESC>:-1r!xclip -o<CR>

noremap tt :tabe  
noremap vv <C-v>
inoremap qq <Esc>
vnoremap qq <Esc>
inoremap uu <Esc>u
inoremap zz <Esc>zza
inoremap aa <Esc>la
inoremap AA <Esc>A
inoremap OO <Esc>o
inoremap ;; <Esc>:
inoremap ;;; ;<Esc>:
noremap ;; :
noremap X :x<esc>
noremap Q :q<esc>
inoremap [ []<ESC>i
inoremap {<cr> {<cr>}<ESC>ko
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
"inoremap $ $$<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
noremap = <C-w>+
noremap - <C-w>-
noremap _ <C-w><
noremap + <C-w>>
noremap sh <C-w>h
noremap sl <C-w>l
noremap sj <C-w>j
noremap sk <C-w>k
noremap ssl gt
noremap ssh gT
noremap <CR> i<CR><ESC>
noremap <C-n> :noh<CR>
tnoremap <Esc> <C-\><C-n><C-w>
tnoremap qq <C-\><C-n><C-w>


set keywordprg=sdcv
"runtime! ftplugin/man.vim

