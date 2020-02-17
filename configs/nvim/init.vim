" { Generics } {{{

    syntax on                         " syntax highlight
    set showcmd                       " Show partial commands in the last line of the screen
    set history=10000                 " history limit
    set cursorline                    " highlight current line
    set autochdir                     " auto chanage the working directory
    set encoding=utf-8                " UTF-8 encodinf
    set diffopt+=iwhite               " ignore whitespace in vimdiff
    set mouse=a                       " enable mouse
    set hidden                        " hides buffers instead of closing them
    set timeout timeoutlen=400        " set timeout to use double key in imap confortablely
    set number relativenumber         " line number
    set backspace=indent,eol,start    " normal delete
    set clipboard=unnamedplus         " use system's clipboard
    set showmatch                     " highlight matching brackets
    set wildmenu                      " show menu for the command completion
    set previewheight=5               " hight of completion preview
    set pumheight=15                  " height of pop-up menu
    set lazyredraw                    " redraw only in need
    set conceallevel=2                " concealment

    " { Tab/spaces } {{{
        set expandtab              " expand tab to spaces
        set smarttab               " use shiftwidth instead of tabstop at start of lines
        set tabstop=4              " set tab to 4-spaces-wide
        set softtabstop=4          " set tab to 4-spaces-wide when editing
        set shiftwidth=4           " < and > will shift 4 spaces

    " }}}

    " { Indention } {{{
        set autoindent
        set smartindent
    " }}}

    " { too long lines } {{{
        " wrap each too long line into multiple rows)
        set wrap

        " movement in too long lines
        nnoremap j gj
        nnoremap k gk
    " }}}

    " { Terminal } {{{
        " exit key mappings
        tnoremap <Esc> <C-\><C-n>
        tnoremap qq <C-\><C-n>
        tnoremap q<Tab> <C-\><C-n>:b#<CR>

        " clean settings in terminal
        autocmd TermOpen * set nonumber norelativenumber signcolumn=no
        autocmd TermOpen * startinsert
        autocmd BufWinEnter,WinEnter term://* startinsert

        " auto close after exited
        autocmd TermClose * call nvim_input("<CR>")

        " function to toggle terminal
        let g:term_buf = 0
        let g:term_win = 0
        function! ToggleTerminal(height)
            if win_gotoid(g:term_win)
                hide
            else
                if bufexists(g:term_buf)
                    exec "split | buffer " . g:term_buf
                else
                    exec "split | terminal"
                    let g:term_buf = bufnr("")
                endif
                let g:term_win = win_getid()
                exec "resize " . a:height
            endif
        endfunction

        " press <F1> to toggle terminal
        nnoremap <silent> <F1> :call ToggleTerminal(12)<CR>
        inoremap <silent> <F1> <Esc>:call ToggleTerminal(12)<CR>
        tnoremap <silent> <F1> <C-\><C-n>:call ToggleTerminal(12)<CR>
    " }}}

" }}}

" { Folding } {{{
    " default foldmethod
    " set foldmethod=syntax

    " fold methods for different filetypes
    autocmd FileType zsh,snippets setlocal foldenable foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType json setlocal foldenable foldmethod=syntax

    " TODO: Python folding
    autocmd FileType python setlocal foldenable foldmethod=manual

    " Press Enter to toggle folding except in quickfix
    nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : 'za'

    " Press Enter to create folding
    vnoremap <CR> zf
" }}}

" { Filetype plugins } {{{
    " enable filtype setting
    filetype plugin indent on

    " edit filetype plugin
    nnoremap <silent> <F5> :exec 'edit $HOME/.config/nvim/ftplugin/' .  &ft . '.vim' <CR>

    " markdown
    autocmd FileType markdown inoremap <silent> <F3> <Esc>:MarkdownPreview<CR>
    autocmd FileType markdown nnoremap <silent> <F3> :MarkdownPreview<CR>

    " yaml, json indent space
    autocmd FileType yaml,json setlocal tabstop=2 softtabstop=2 shiftwidth=2
" }}}

" { Search configuration } {{{
    set ignorecase  " ignore case during search
    set smartcase   " ignore case if search pattern is all lowercase
    set hlsearch    " highlight search
    set incsearch   " incremental search

    " next/previous search
    vnoremap n "ny/<C-r>n<CR>
    vnoremap N "ny/<C-r>n<CR>NN
    vnoremap C "ny/<C-r>n<CR>Ncgn


    " grep search and show on quickfix
    vnoremap <C-f> y:vimgrep <C-r>" %<CR> \| :copen <CR>
    nnoremap <C-f> :vimgrep <C-r>/ %<CR> \| :copen <CR>

    " search/substitute
    vnoremap / :s///gc<Left><Left><Left><Left>
" }}}

" { Color } {{{
    set background=dark
    set synmaxcol=150          " limit max columns of highlight to prevent slowing down
    colorscheme elflord

    " highlight for searching text
    highlight Search ctermfg=red ctermbg=none

    " highlight for pop-up menu
    highlight Pmenu ctermbg=blue guibg=none

    " toggle concealment
    nnoremap <Space>cc :setlocal conceallevel=<c-r>=&conceallevel == 0 ? '2' : '0'<cr><cr>

    " toggle highlight search
    nnoremap <Space>ch :set hlsearch! hlsearch?<CR>
" }}}

" { Plugins } {{{
    call plug#begin('~/.local/share/nvim/plugged')
    Plug 'bling/vim-airline'                                                " status and tab line
    Plug 'vim-airline/vim-airline-themes'                                   " collection of themes for vim-airline
    Plug 'Shougo/neco-vim'                                                  " vim completion for deoplete
    Plug 'ervandew/supertab'                                                " perform completion with Tab
    Plug 'jiangmiao/auto-pairs'                                             " auto pair brackets, parens, quotes
    Plug 'tpope/vim-surround'                                               " auto surround brackets, parens, quotes
    Plug 'Yggdroot/indentLine'                                              " display the indention levels with thin vertical lines
    Plug 'tpope/vim-fugitive'                                               " git helper for vim
    Plug 'scrooloose/nerdcommenter'                                         " comment helper
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }           " dark powered asynchronous completion framework
    Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }              " python completion for deoplete via jedi
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }                          " Racer support for Vim
    Plug 'godlygeek/tabular'                                                " text alignment
    Plug 'yegappan/mru'                                                     " Most Recently Used (MRU)
    Plug 'SirVer/ultisnips'                                                 " ultimate snippet solution for Vim
    Plug 'FooSoft/vim-argwrap'                                              " wrap/unwrap arguments
    Plug 'lervag/Vimtex', { 'for': 'tex' }                                  " plugin for editing LaTeX files
    Plug 'PietroPate/vim-tex-conceal', { 'for': 'tex' }                     " Improved conceal for tex in vim
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " markdown previewer with node.js
    Plug 'Lokaltog/neoranger'                                               " integrate ranger with vim
    Plug 'neomake/neomake'                                                  " asynchronous linting and make framework
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }                        " jedi autocompletion library
    Plug 'skywind3000/asyncrun.vim'                                         " run shell asynchronously and output to quickfix
    call plug#end()
" }}}

" { Plugins config } {{{

    " { jedi-vim } {{{
        " disable jedi default completion, use depolete-jedi at below instead
        let g:jedi#auto_vim_configuration = 0
        let g:jedi#completions_enabled = 0
        let g:jedi#popup_on_dot = 0
        let g:jedi#smart_auto_mappings = 1

        " key mappings
        let g:jedi#goto_command = "gd"
        let g:jedi#documentation_command = "K"
    " }}}

    " { neoranger } {{{
        let g:neoranger_viewmode='miller'
        nnoremap <Space>r :Ranger<CR>
    " }}}

    " { vimtex } {{{

        " avoid plaintex
        let g:tex_flavor='latex'

        let g:vimtex_view_method = 'zathura'
        " let g:vimtex_fold_manual=0

        " enable folding
        let g:vimtex_fold_enabled=1

        " disable folding for some types
        let  g:vimtex_fold_types = {
        \    'envs' : {
        \       'blacklist' : ['equation*', 'align*'],
        \    },
        \}

    " }}}

    " { tex-conceal } {{{
        " a: accents/ligatures
        " b: bold and italic
        " d: delimiters
        " m: math symbols
        " g: Greek
        " s: superscripts/subscripts
        let g:tex_conceal='abdmgs'
    " }}}

    " { neomake } {{{
        " disable error after text
        let g:neomake_virtualtext_current_error=0

        " auto display the error list
        let g:neomake_open_list = 2

        " limit the error list in 5 lines height
        let g:neomake_list_height = 5

        " for python
        call neomake#configure#automake('w')
        let g:neomake_python_enabled_makers = ['flake8', 'mypy']

        " TODO: for tex
        " let g:neomake_tex_enabled_makers = ['chktex', 'rubberinfo', 'proselint']
    " }}}

    " { vim-argwrap } {{{
        nnoremap <silent> <Space>a :ArgWrap<CR>
    " }}}

    " { ultisnips } {{{
        let g:UltiSnipsExpandTrigger="<c-e>"
        let g:UltiSnipsJumpForwardTrigger="<c-e>"
        let g:UltiSnipsJumpBackwardTrigger="<c-w>"
        let g:UltiSnipsSnippetDirectories=['snips']
        snoremap qq <Esc>
        nnoremap <silent> <F4> :exec 'edit $HOME/.config/nvim/snips/' .  &ft . '.snippets' <CR>
    " }}}

    " { MRU } {{{
        " Toggle MRU
        nnoremap <Space>f :MRU<CR>
    " }}}

    " { tabular } {{{
        vnoremap \ :Tabularize /
    " }}}

    " { vim-fugitive } {{{
        " press <space + g> to toggle git helper
        nnoremap <Space>g :G<CR>
    " }}}

    " { nerdcommenter } {{{

        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims            = 1

        " Disable commenting empty lines
        let g:NERDCommentEmptyLines      = 0

        " use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs        = 1

        " trim trailing whitespace
        let g:NERDTrimTrailingWhitespace = 1

        " left align the comment
        let g:NERDDefaultAlign           = 'left'

        " customize delimiters
        let g:NERDCustomDelimiters       = {
            \ 'c':{'left':'//'},
            \ 'python':{'left':'#'},
            \ 'arduino':{'left':'//'}
        \ }

        " press Backspace to toggle commenter
        nmap <BS> <plug>NERDCommenterToggle
        vmap <BS> <plug>NERDCommenterToggle

    " }}}

    " { vim-surround } {{{
        " press s to trigger surround
        xmap s <Plug>VSurround
        xmap gs <Plug>VgSurround
    " }}}

    " { indentLine } {{{
        let g:indentLine_color_term = 245
        let g:indentLine_fileTypeExclude = ['tex']

        " use system default conceal
        let g:indentLine_setConceal = 0

        " different symbols for each level"
        let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    " }}}

    " { supertab } {{{
        " make completion from top to bottom
        let g:SuperTabDefaultCompletionType = "<C-n>"
    " }}}

    " { depolete } {{{
        let g:deoplete#enable_at_startup = 1

        " TODO: show information
        " press <F10> to toggle deoplete
        nnoremap <F10> :call deoplete#toggle()<CR>
        inoremap <F10> :call deoplete#toggle()<CR>
    " }}}

    " { vim-racer } {{{
        let g:racer_experimental_completer = 1  " show the complete function definition
        let g:racer_insert_paren = 1            " insert the parenthesis in the completion
    " }}}

    " { auto-pairs } {{{
        let g:AutoPairsShortcutBackInsert = ''                     " disable
    " }}}

    " { vim-airline config } {{{
        set laststatus=2                                           " set status line
        let g:airline#extensions#tabline#enabled = 1               " displays all buffers when there's only one tab open
        let g:airline#extensions#bufferline#enabled = 1
        let g:airline_powerline_fonts = 1                          " enable powerline-fonts
        let g:airline#extensions#tabline#fnamemod = ':t'           " show file name only
        let g:airline#extensions#tabline#show_tab_nr = 1
        let g:airline#extensions#tabline#tab_nr_type = 1
        let g:airline#extensions#tabline#buffer_idx_mode = 1
        let g:airline#extensions#whitespace#enabled = 0            " disable whitespace check

        " map <space>+1~9 to switch no.1~9 tab on tabline
        let i = 1
        while i <= 9
            execute 'nmap <Space>' . i . ' <Plug>AirlineSelectTab' . i
            let i = i + 1
        endwhile

        " next/previous tab
        nmap <C-l> <Plug>AirlineSelectNextTab
        nmap <C-h> <Plug>AirlineSelectPrevTab
    " }}}

    " { asyncrun.vim } {{{
        " integration with vim airline(must after airline config)
        let g:asyncrun_status = ''
        let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
    " }}}

" }}}

" { Buffer saving/loading/exit } {{{
    " auto save and restore
    set vop=folds,cursor,curdir  " save folds, cursor position, working directory only
    let blacklist = ['qf']
    autocmd BufWinLeave ?* if index(blacklist, &ft) < 0 | mkview
    autocmd BufRead ?* if index(blacklist, &ft) < 0 | silent! loadview

    " Auto search and clean trailing space after file written.
    autocmd BufWritePre * %s/\s\+$//e

    " save and (force) exit
    noremap Q :q<CR>
    noremap ! :q!<CR>
    noremap X :x<CR>
    nnoremap <Space>w :w<CR>
    nnoremap <Space>x :x<CR>
    autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif

    function! QuitOrBufferDelete()
        let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
        let empty_name = (expand('%') == '')
        if (buf_len && empty_name)
            exec 'q'
        else
            exec 'bd'
        endif
    endfunction
    nnoremap <silent> <Space>q :exec QuitOrBufferDelete()<CR>
" }}}

" { Key mappings } {{{


    " jump between changes and view in middle
    nnoremap g; g;zz
    nnoremap g, g,zz

    " number increment: press <C-s>/<C-x> to increase/decrease 1
    nnoremap <C-s> <C-a>

    " redo/undo
    nnoremap U <C-r>
    inoremap uu <Esc>u

    " visual selection
    nnoremap vv <C-v>

    " Text editing
    inoremap aa <Esc>la

    " yy yank a line with line break, and Y yank a plain line
    nnoremap Y y$

    " { vimrc } {{{
        nnoremap <Space>ve :e $MYVIMRC<CR>
        nnoremap <Space>vv :source $MYVIMRC<CR>
        nnoremap <Space>vi :source $MYVIMRC<CR> :PlugInstall<CR>
        nnoremap <Space>vc :PlugClean<CR>
    " }}}

    " { Movement with in line } {{{
        " begining & end
        nnoremap B ^
        nnoremap E $
        vnoremap B ^
        vnoremap E $h

        " emacs-like
        inoremap <M-f> <Esc>lwi
        inoremap <M-b> <Esc>bi
    " }}}

    " { Command mode mapping } {{{
        cnoremap <M-b> <S-Left>
        cnoremap <M-f> <S-Right>
        cnoremap <C-a> <Home>
    " }}}

    " { Dragging line vertically } {{{
        nnoremap <C-u> :m .-2<CR>
        nnoremap <C-d> :m .+1<CR>
        inoremap <C-u> <Esc>:m .-2<CR>gi
        inoremap <C-d> <Esc>:m .+1<CR>gi
        vnoremap <C-u> :m '<-2<CR>gv=gv
        vnoremap <C-d> :m '>+1<CR>gv=gv
    " }}}

    " { Dragging line horizontally } {{{
        nnoremap > >>
        nnoremap < <<

        " indent and re-select
        vnoremap > >gv
        vnoremap < <gv
    " }}}

    " { Page scrolling } {{{
        nnoremap <C-k> <C-u>
        nnoremap <C-j> <C-d>
        inoremap <C-k> <Esc><C-u>
        inoremap <C-j> <Esc><C-d>
    " }}}

    " { Escape key mapping } {{{
        nnoremap q  <Esc>
        nnoremap qq <Esc>
        vnoremap q  <Esc>
        inoremap qq <Esc>
    " }}}

" }}}

" { Windows/Buffers settings } {{{

    " jump between buffers
    nnoremap <Tab> :b#<CR>

    " resizing
    nnoremap = <C-w>+
    nnoremap - <C-w>-
    nnoremap _ <C-w><
    nnoremap + <C-w>>

    " navigation
    nnoremap <Space>h     <C-w>h
    nnoremap <Space>l     <C-w>l
    nnoremap <Space>j     <C-w>j
    nnoremap <Space>k     <C-w>k
    nnoremap <Space><Tab> <C-w><C-p>

    " split window
    set splitbelow splitright " specify the location
    nnoremap <Space>s :vsp \| b<Space>

" }}}

" { spell check } {{{
    " turn off by default
    set nospell

    " store custom spell dictionary
    set spellfile=~/.vim/spell/en.utf-8.add

    " make check supports English, Chinese, Japanese, Korean
    setlocal spelllang=en_us,cjk

    " auto spelling check for some file types
    autocmd BufRead,BufNewFile *.md,*.txt,*.tex,*.adoc if &l:buftype !=# 'help' | setlocal spell | endif

    " TODO
    inoremap <c-k> <c-g>u<Esc>[s1z=`]a<c-g>u

    " use <F8> to toggle spell check
    nnoremap <silent> <F8> :setlocal spell!<CR>
    inoremap <silent> <F8> <ESC>:setlocal spell!<CR>i
" }}}
