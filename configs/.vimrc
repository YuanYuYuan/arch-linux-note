syntax on
filetype off
set nocompatible
set mouse=a 
set ai "autoIndent
set smartindent
set background=dark
set shiftwidth=4
set tabstop=4 
set ruler
set number
set showcmd
set expandtab "change tab to space
set incsearch "incremental search"
set ignorecase
set history=200
set cursorline
set completeopt-=preview
set autochdir
set splitbelow
set splitright
set hidden
set shell=/usr/bin/zsh
set wildmenu
set hlsearch
set t_Co=256

if has('clipboard')
    if has('unnamedplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" autocmd BufWinLeave ?* mkview
" autocmd BufWinEnter ?* silent loadview

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
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
Plugin 'tpope/vim-vinegar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdcommenter'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/limelight.vim'

call vundle#end()

filetype  plugin indent on


" remap leader key
let mapleader = ","

" NERDCommenter
let g:NERDSpaceDelims            = 1
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCompactSexyComs        = 1
let g:NERDDefaultAlign           = 'left'
nmap <BS> <plug>NERDCommenterToggle
vmap <BS> <plug>NERDCommenterToggle


" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_paragraph_span = 1

" Quickfix toggle
nnoremap <F5> :call asyncrun#quickfix_toggle(8)<cr> 

" Tagbar
let g:tagbar_compact   = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
let g:tagbar_type_arduino = {
    \ 'ctagstype' : 'c++',
    \ 'kinds'     : [
        \ 'd:macros:1:0',
        \ 'p:prototypes:1:0',
        \ 'g:enums',
        \ 'e:enumerators:0:0',
        \ 't:typedefs:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:variables:0:0'
    \ ],
    \ 'sro'        : '::',
\ }

"vim-airline
let g:airline#extensions#tabline#enabled = 1
" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts = 1
" show file name only
let g:airline#extensions#tabline#fnamemod = ':t'

"vim-airline-themes
let g:airline_theme = 'wombat'

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
let g:syntastic_check_on_open      = 1
let g:syntastic_check_on_wq        = 0
let g:syntastic_python_python_exec = '/usr/bin/python2.7'

" netrw/explore config
let g:netrw_winsize   = 25
let g:netrw_banner    = 0
let g:netrw_liststyle = 3

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_types       = ['mru', 'buf', 'fil']


"nnoremap <silent> <F2> :Lex<CR>
"inoremap <silent> <F2> <ESC>:Lex<CR>
nnoremap <silent> <F2> :NERDTreeToggle<CR>
inoremap <silent> <F2> <ESC>:NERDTreeToggle<CR>
nnoremap <silent> <F4> :TagbarToggle<CR>
inoremap <silent> <F4> <ESC>:TagbarToggle<CR>
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
		exec "AsyncRun arduino --upload $PWD/%"
        "exec "!pio run -t upload"
	elseif &filetype == "sh"
		exec "!sh %"
	elseif &filetype == "html"
		exec "!xdg-open %"
    elseif &filetype == "xdefaults"
        exec "!xrdb %"
	endif
endfunc

nnoremap U <C-r>
nnoremap E b
noremap vv <C-v>
inoremap qq <Esc>
vnoremap qq <Esc>
inoremap uu <Esc>u
inoremap zz <Esc>zza
inoremap aa <Esc>la
inoremap AA <Esc>A
inoremap OO <Esc>o
"inoremap ;; <Esc>:
"inoremap ;;; ;<Esc>:
"noremap ;; :
noremap X :x<esc>
noremap Q :q<esc>
inoremap [ []<ESC>i
inoremap {<cr> {<cr>}<ESC>ko
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap $ $$<ESC>i
inoremap $$ $
inoremap " ""<ESC>i
inoremap "" "
inoremap ' ''<ESC>i
inoremap '' '

nnoremap = <C-w>+
nnoremap - <C-w>-
nnoremap _ <C-w><
nnoremap + <C-w>>

nnoremap sh <C-w>h
nnoremap sl <C-w>l
nnoremap sj <C-w>j
nnoremap sk <C-w>k

"augroup netrw_mapping
    "autocmd!
    "autocmd filetype netrw call NetrwMapping()
"augroup END

"function! NetrwMapping()
    "nnoremap <buffer> sh <C-w>h
    "nnoremap <buffer> sl <C-w>l
    "nnoremap <buffer> sj <C-w>j
    "nnoremap <buffer> sk <C-w>k
"endfunc

"17-05-17 change tab to buffer
"noremap tt :tabe 
"noremap <C-l> gt
""if has('nvim')
""    noremap <BS> gT
""    tnoremap <Esc> <C-\><C-n><C-w>
""    tnoremap qq <C-\><C-n><C-w>
""else
""    noremap <C-h> gT
""endif
"noremap <C-h> gT


"buffer
nnoremap <C-n> :ene\|e 
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
nnoremap <Tab> <C-^>

if has('nvim')
    tnoremap \ <C-\><C-n>
endif

nnoremap <C-u> :m .-2<CR>
nnoremap <C-d> :m .+1<CR>
inoremap <C-u> <Esc>:m .-2<CR>gi
inoremap <C-d> <Esc>:m .+1<CR>gi
vnoremap <C-u> :m '<-2<CR>gv=gv
vnoremap <C-d> :m '>+1<CR>gv=gv

nnoremap L 7l
nnoremap J <C-d>
nnoremap K <C-u>
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
inoremap <C-j> <Esc><C-d>
inoremap <C-k> <Esc><C-u>

nnoremap <CR> i<CR><ESC>
nnoremap H :set hlsearch! hlsearch?<CR>

cnoremap <C-a> <Home>
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>



noremap S K
set keywordprg=sdcv
