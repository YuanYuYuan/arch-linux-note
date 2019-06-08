"" Basic Configs
syntax on
filetype off
set nocompatible
set ruler
set showcmd
set history=200
set cursorline
set autochdir
set wildmenu
set encoding=utf-8
set diffopt+=iwhite
set mouse=a                " enable mouse
set expandtab              " change tab to space
set smarttab               " use shiftwidth instead of tabstop at start of lines
set tabstop=4              " set tab to 4-spaces-wide
set shiftwidth=4           " < and > will shift 4 spaces
set hidden                 " hides buffers instead of closing them
set timeout timeoutlen=400 " set timeout to use double key in imap confortablely
set number relativenumber  " line number
set wrap                   " line wrap(shows a too long line in multiple rows)

" color/colorscheme/syntax
set background=dark
set synmaxcol=150          " set syntax (highlight) max columns to avoid slow down
set t_Co=256
colorscheme elflord

" conceal
set conceallevel=1
nnoremap <Space>c :setlocal conceallevel=<c-r>=&conceallevel == 0 ? '2' : '0'<cr><cr>

" move in too long lines
nnoremap j gj
nnoremap k gk

" scroll offset(line numbers)
if !&scrolloff
    set scrolloff=1
endif

" auto save and restore
let blacklist = ['qf']
autocmd BufWinLeave ?* if index(blacklist, &ft) < 0 | mkview
autocmd BufWinEnter ?* if index(blacklist, &ft) < 0 | silent loadview
autocmd VimLeave * call system("xclip -o | xclip -selection c")

"" Plugins
call plug#begin('~/.vim/plugged')
Plug 'godlygeek/tabular'                                      " vim script for text filtering and alignment
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }         " markdown Vim Mode
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }          " supports i3 syntax
Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'config' } " supports systemd syntax
Plug 'bling/vim-airline'                                      " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'                         " collection of themes for vim-airline
Plug 'iamcco/markdown-preview.vim'                            " Real-time markdown preview plugin for vim
Plug 'iamcco/mathjax-support-for-mkdp'                        " mathjax support for markdown-preview.vim plugin
Plug 'tpope/vim-surround'                                     " quoting/parenthesizing made simple
Plug 'Yggdroot/indentLine'                                    " display the indention levels with thin vertical lines
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }            " vim plugin that displays tags in a window, ordered by scope
Plug 'easymotion/vim-easymotion'                              " vim motions on speed
Plug 'junegunn/limelight.vim'                                 " hyperfocus-writing in Vim
Plug 'junegunn/goyo.vim'                                      " distraction-free mode
Plug 'vim-scripts/Txtfmt-The-Vim-Highlighter'                 " Rich text highlighting in Vim! (colors, underline, bold, italic, etc...)
Plug 'yegappan/mru'                                           " Most Recently Used (MRU) Vim Plugin
Plug 'tpope/vim-repeat'                                       " enable repeating suppordted plugin maps with dot
Plug 'lervag/Vimtex', { 'for': 'tex' }                        " plugin for editing LaTeX files
Plug 'PietroPate/vim-tex-conceal', { 'for': 'tex' }           " Improved conceal for tex in vim
Plug 'SirVer/ultisnips'                                       " ultimate snippet solution for Vim
Plug 'tpope/vim-commentary'                                   " comment stuff out
Plug 'scrooloose/nerdcommenter'                               " vim plugin for intensely orgasmic commenting
Plug 'tpope/vim-fugitive'                                     " A Git wrapper so awesome, it should be illegal
Plug 'vim-scripts/DrawIt'                                     " Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'baskerville/vim-sxhkdrc'                                " Vim syntax for sxhkd's configuration files
Plug 'skywind3000/asyncrun.vim'                               " run Async Shell Commands in  Quickfix Window
Plug 'maralla/completor.vim'                                  " Async completion framework made ease
Plug 'w0rp/ale'                                               " Asynchronous Lint Engine
Plug 'michaeljsmith/vim-indent-object'                        " Defines new text objects representing lines at the same indent level.




" ==================== Unused plugins ====================
" Plug 'ervandew/supertab'                                      " perform all vim insert mode completions with Tab
" Plug 'davidhalter/jedi-vim', { 'for': 'python'}               " Using the jedi autocompletion library for VIM
" Plug 'ajh17/VimCompletesMe'                                   " A super simple, super minimal, super light-weight tab completion plugin for Vim
" Plug 'jpalardy/vim-slime'
" Plug 'jiangmiao/auto-pairs'
" Plug 'NBUT-Developers/extra-instant-markdown'                 " instant Markdown previews from VIM
" Plug 'ervandew/screen'
" Plug 'python-mode/python-mode'                                " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
" Plug 'honza/vim-snippets'                                     " vim-snipmate default snippets
" Plug 'junegunn/vim-easy-align'                                " alignment plugin
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }        " tree explorer plugin for vim
" Plug 'Xuyuanp/nerdtree-git-plugin'                            " plugin of NERDTree showing git status
" Plug 'francoiscabrol/ranger.vim'                              " ranger integration in vim
" Plug 'terryma/vim-multiple-cursors'                           " True Sublime Text style multiple selections for Vim
" Plug 'scrooloose/syntastic'                                   " syntax checking hacks for vim
" Plug 'dhruvasagar/vim-table-mode'
" Plug 'ctrlpvim/ctrlp.vim'                                     " fuzzy file, buffer, mru, tag, etc finder.
" Plug 'Valloric/YouCompleteMe'                                 " code completion engine for vim

call plug#end()

filetype plugin indent on


""  ==================== Plugin Config ====================

" completor
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:completor_auto_trigger = 0
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :  "\<C-R>=completor#do('complete')\<CR>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" auto-pairs
" let g:AutoPairsFlyMode = 1
" let g:AutoPairsShortcutToggle = '<Space>p'
" let g:AutoParis = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '$':'$'}

" vim-surround
xmap s <Plug>VSurround
xmap gs <Plug>VgSurround

" jedi-vim
" let g:jedi#popup_on_dot = 1

" VimCompletesMe
" autocmd FileType vim let b:vcm_tab_complete = 'vim'
" let g:vcm_direction = 'p'

" " vim-slime
" let g:slime_target = "tmux"
" let g:slime_python_ipython = 1
" let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}

" easymotion
nmap s <Plug>(easymotion-s)
" nmap S <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

" indentline
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_color_term = 245
let g:indentLine_fileTypeExclude = ['tex']

" vim-table-mode
let g:table_mode_corner = '|'

" NERDCommenter
let g:NERDSpaceDelims            = 1
let g:NERDCommentEmptyLines      = 0
let g:NERDCompactSexyComs        = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCustomDelimiters       = {'c':{'left':'//'}, 'python':{'left':'#'}, 'arduino':{'left':'//'}}
nmap <BS> <plug>NERDCommenterToggle
vmap <BS> <plug>NERDCommenterToggle

" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_paragraph_span  = 1

" Goyo
let g:goyo_width = '100%'
let g:goyo_hight = '85%'
let g:goyo_linenr = '1'

" Tagbar
nnoremap <silent> <F1> :TagbarToggle<CR>
inoremap <silent> <F1> <ESC>:TagbarToggle<CR>
let g:tagbar_compact      = 1
let g:tagbar_autoclose    = 1
let g:tagbar_autofocus    = 1
let g:tagbar_left         = 1
let g:tagbar_width        = 40
" let g:tagbar_vertical     = 15
let g:tagbar_sort         = 0
let g:tagbar_show_linenumbers = 1
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

" vim-airline
let g:airline#extensions#tabline#enabled = 1               " Automatically displays all buffers when there's only one tab open
set laststatus=2                                           " set status line
let g:airline_powerline_fonts = 1                          " enable powerline-fonts
let g:airline#extensions#tabline#fnamemod = ':t'           " show file name only
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#enabled = 0            " disable whitespace check
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" nmap <leader>- <Plug>AirlineSelectPrevTab
" nmap <leader>+ <Plug>AirlineSelectNextTab

"vim-airline-themes
let g:airline_theme = 'wombat'

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_frontmatter = 1

" netrw/explore config
let g:netrw_winsize   = 25
let g:netrw_banner    = 0
let g:netrw_liststyle = 0

" ultisnips config
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my-snippets"]

" supertab config
" let g:SuperTabContextDefaultCompletionType = "<c-p>"
" let g:SuperTabDefaultCompletionType = "<c-p>"
" let g:SuperTabClosePreviewOnPopupClose = 1

" Presentation/Focus mode
nnoremap <silent> <F7> :Goyo \| Limelight!! \| so ~/.vimrc<CR>
inoremap <silent> <F7> <ESC>:Goyo \| Limelight!! \| so ~/.vimrc<CR>

" Quickfix toggle
nnoremap <silent> <F2> :call asyncrun#quickfix_toggle(8)<cr>

" Quickfix height
au FileType qf call AdjustWindowHeight(3, 7)
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Tabular config
vnoremap \ :Tabularize /

" ALE config
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fixers = {
\    'python': ['autopep8']
\}
let g:ale_linters = {
\   'python': ['flake8'],
\   'zsh': ['shell'],
\}

" MRU config
nnoremap <Space>f :MRU<CR>

" Vimtex config
let g:tex_conceal='abdmg'
" avoid plaintex
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_fold_manual=1


" ==================== Run Script Function ====================
nnoremap <silent> <Space>r :call RunScript()<CR>
nnoremap <silent> <F3> :call RunScript()<CR>
imap <silent> <F3> <ESC>:call RunScript()<CR>
func! RunScript(...)
	exec "w"
	if &filetype == "c"
		exec "!gcc % -o %< && ./%<"
	elseif &filetype == "cpp"
		exec "!g++ % -o %< && ./%<"
	elseif &filetype == "java"
		exec "!javac % && java %<"
	elseif &filetype == "markdown"
		exec "MarkdownPreview"
	elseif &filetype == "javascript"
		exec "!node %"
	elseif &filetype == "python"
		exec "!python %"
	elseif &filetype == "arduino"
		exec "AsyncRun arduino --upload $PWD/%"
        "exec "!pio run -t upload"
	elseif &filetype == "sh"
		exec "!sh %"
	elseif &filetype == "html"
		exec "!gio open %"
    elseif &filetype == "xdefaults"
        exec "!xrdb %"
	endif
endfunc

" remap leader key
let mapleader = "\<space>"


" Escape key mapping
nnoremap q <Esc>
vnoremap qq <Esc>
inoremap qq <Esc>
nnoremap qq <Esc>

" redo/undo
nnoremap U <C-r>
inoremap uu <Esc>u

nnoremap vv <C-v>

" Text editing
inoremap aa <Esc>la
nnoremap O o<ESC>


"" Window Settings
" window resize
nnoremap = <C-w>+
nnoremap - <C-w>-
nnoremap _ <C-w><
nnoremap + <C-w>>

" window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Tab> <C-w><C-p>

" split window
set splitbelow
set splitright
nnoremap <Space>s :vsp \| b<Space>

" ===== search =====
set ignorecase " search ignorecasely
set smartcase  " ignore case if search pattern is all lowercase
set hlsearch   " highlight search
set incsearch  " incremental search
hi search ctermfg=red ctermbg=none

" next/previous search
vnoremap n y/<C-r>"<CR>
vnoremap N y/<C-r>"<CR>NN

" toggle highltight search
nnoremap <Space>n :set hlsearch! hlsearch?<CR>

" grep search and show on quickfix
vnoremap <C-f> y:vimgrep <C-r>" %<CR> \| :copen <CR>
nnoremap <C-f> :vimgrep <C-r>/ %<CR> \| :copen <CR>

" search/subsititute
vnoremap / :s///gc<Left><Left><Left><Left>

" Auto search and clean trailing space after wrote file.
autocmd BufWritePre * %s/\s\+$//e

" quick jump during visual selection
vnoremap , f,
vnoremap ; f;
vnoremap ) f)
vnoremap <CR> $h


" number increment
nnoremap <C-s> <C-a>

" buffer
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <Space><Tab> :b#<CR>
" nnoremap L :bn<CR>
" nnoremap H :bp<CR>
" nnoremap <Tab> <C-^>
" nnoremap <leader>q :bd<CR>
function! QuitOrBufferDelete()
    let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
    let empty_name = (expand('%') == '')
    if (buf_len && empty_name)
        exec 'q'
    else
        exec 'bd'
    endif
endfunction
nnoremap <silent> <leader>q :exec QuitOrBufferDelete()<CR>

" move lines
nnoremap <C-u> :m .-2<CR>
nnoremap <C-d> :m .+1<CR>
inoremap <C-u> <Esc>:m .-2<CR>gi
inoremap <C-d> <Esc>:m .+1<CR>gi
vnoremap <C-u> :m '<-2<CR>gv=gv
vnoremap <C-d> :m '>+1<CR>gv=gv

" page scrolling
nnoremap J <C-e>
nnoremap K <C-y>
vnoremap J <C-e>
vnoremap K <C-y>
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
inoremap <C-k> <Esc><C-u>
inoremap <C-j> <Esc><C-d>

" command mode mapping
cnoremap b      <S-Left>
cnoremap f      <S-Right>
cnoremap <C-a>    <Home>

" cursor movement in imap
" inoremap <C-a>    <Home>
" inoremap <C-e>    <End>

" macros
nnoremap T qt
nnoremap t @t

" indent
set autoindent
set smartindent
nnoremap > >>
nnoremap < <<

" copy/paste/clipboard
if has('clipboard')
    if has('unnamedplus') " + register
        set clipboard=unnamed,unnamedplus
    else " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif
nnoremap PP "0p
vnoremap PP "0p
" select pasted text
nnoremap gp `[v`]


" quit/exit
noremap Q :q<CR>
noremap ! :q!<CR>
noremap X :x<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif

noremap ;; q:

" naviagate in <++>
" inoremap <Space><Tab> <Esc>/<+.*+><Enter>ca<
" vnoremap <Space><Tab> <Esc>/<+.*+><Enter>ca<
" map      <Space><Tab> <Esc>/<+.*+><Enter>ca<

" fold
nnoremap zp vipzf
set foldmethod=manual

" dictionary
nnoremap <leader>d K
set keywordprg=sdcv

" spell check
setlocal spell spelllang=en_us
set spell!
nnoremap <silent> <F8> :set spell!<CR>
inoremap <silent> <F8> <ESC>:set spell!<CR>i
inoremap <c-k> <c-g>u<Esc>[s1z=`]a<c-g>u

" Fn maps
nnoremap <F5> :source ~/.vimrc<CR>
nnoremap <F4> :exec 'edit $HOME/.vim/my-snippets/' .  &ft . '.snippets' <CR>
set pastetoggle=<F10>

"" Completion
" set complete+=k$HOME/.vim/spell/en.utf-8.add
" set omnifunc=syntaxcomplete#Complete
" set completeopt=menuone
" autocmd FileType python set omnifunc=python3complete#Complete
" set completeopt=menuone,preview
" autocmd FileType python set omnifunc=jedi#completions
inoremap <C-f> <C-x><C-F>
inoremap <C-d> <C-x>s
" inoremap <expr> <C-o> pumvisible() ? "\<C-y>" : "\<C-o>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


" brackets completion
inoremap [ []<ESC>i
inoremap {<CR> {<CR>}<ESC>ko
inoremap { {}<ESC>i
inoremap ( ()<ESC>i

" quotes completion
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
