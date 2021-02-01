" { Generics } {{{

    syntax on                         " syntax highlight
    syntax sync fromstart
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
    set showmatch                     " highlight matching brackets
    set wildmenu                      " show menu for the command completion
    set previewheight=5               " hight of completion preview
    set pumheight=10                  " height of pop-up menu
    set conceallevel=2                " concealment

    " { Clipboard } {{{
        " use system's clipboard
        set clipboard=unnamedplus

        " paste last buffer
        vnoremap <Space>p "0p
        nnoremap <Space>p "0p
    " }}}

    " { Ignoring case } {{{
        set ignorecase  " ignore case during search
        set smartcase   " ignore case if search pattern is all lowercase
        set wildignorecase " ignore case when doing completion
    " }}}

    " { Lazyredraw } {{{
        " TODO: Improve implementation
        " redraw only in need
        set nolazyredraw
        " autocmd InsertLeave * set lazyredraw
        " autocmd InsertEnter * set nolazyredraw

        function! ToggleLazyRedraw()
            exec 'set lazyredraw!'
            if &lazyredraw == 0
                echo 'LazyRedraw off'
            else
                echo 'LazyRedraw on'
            endif
        endfunction
        nnoremap <Space>cr :call ToggleLazyRedraw()<CR>
    " }}}

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
        tnoremap q<Tab> <C-\><C-n><C-w><C-p>

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
                if bufexists(g:term_buf) && g:term_buf != 0
                    exec "split | buffer " . g:term_buf
                else
                    exec "split | terminal"
                    let g:term_buf = bufnr("")
                endif
                let g:term_win = win_getid()
                exec "resize " . a:height
            endif
        endfunction

        " press <F7> to toggle terminal
        nnoremap <silent> <F7> :call ToggleTerminal(12)<CR>
        inoremap <silent> <F7> <Esc>:call ToggleTerminal(12)<CR>
        tnoremap <silent> <F7> <C-\><C-n>:call ToggleTerminal(12)<CR>
    " }}}
    " { Completion } {{{
        " The tab trigger is done by SuperTab.
        " And the intelligent completion relies on coc.vim.
        " But note that the completion in Julia is handled by julia-vim

        " Press <Enter> to select the completion
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " }}}

" }}}

" { Folding } {{{
    " default foldmethod
    " set foldmethod=syntax

    " disable auto-open while paragraph navigation
    set foldopen-=block

    " fold methods for different filetypes
    autocmd FileType tmux,zsh,snippets setlocal foldenable foldmethod=marker foldmarker={{{,#\ }}}
    autocmd FileType vim setlocal foldenable foldmethod=marker
    autocmd FileType json setlocal foldenable foldmethod=syntax
    autocmd FileType json5 setlocal foldenable foldmethod=indent
    autocmd FileType asciidoc,dot setlocal noexpandtab
    autocmd BufRead,BufNewFile *.gv set filetype=dot

    " TODO: Python folding
    autocmd FileType python setlocal foldenable foldmethod=manual

    function! FoldOrSelect()
        if foldlevel(line('.')) == 0
            call feedkeys("vip")
        else
            call feedkeys("za")
        endif
    endfunction

    " Press Enter to toggle folding except in quickfix
    " nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : "call FoldOrSelect()"
    nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":call FoldOrSelect()<CR>"

    " Press Enter to create folding
    vnoremap <CR> zf
" }}}

" { Filetype plugins } {{{
    " enable filtype setting
    filetype plugin indent on

    " edit filetype plugin
    nnoremap <silent> <F5> :exec 'edit $HOME/.config/nvim/ftplugin/' .  &ft . '.vim' <CR>

    " markdown
    autocmd FileType markdown inoremap <buffer> <silent> <F3> <Esc>:MarkdownPreview<CR>
    autocmd FileType markdown nnoremap <buffer> <silent> <F3> :MarkdownPreview<CR>

    " json5
    autocmd FileType json5 inoremap <buffer> <silent> <F3> <Esc>:!json5 -v %<CR>
    autocmd FileType json5 nnoremap <buffer> <silent> <F3> :!json5 -v %<CR>

    " c
    function! RunC()
        exec "!gcc % -o %< && ./%<"
    endfunction
    autocmd FileType c inoremap <buffer> <silent> <F3> <Esc>:call RunC()<CR>
    autocmd FileType c nnoremap <buffer> <silent> <F3> :call RunC()<CR>

    " yaml, json indent space
    autocmd FileType yaml,json,json5 setlocal tabstop=2 softtabstop=2 shiftwidth=2

" }}}

" { Search configuration } {{{
    set hlsearch    " highlight search
    set incsearch   " incremental search

    " next/previous search
    vnoremap 0 n
    vnoremap 9 N
    vnoremap n "ny/<C-r>n<CR>
    vnoremap N "ny/<C-r>n<CR>NN
    vnoremap C "ny/<C-r>n<CR>Ncgn

    " grep search and show on quickfix
    vnoremap <C-f> y:vimgrep <C-r>" %<CR> \| :copen <CR>
    nnoremap <C-f> :vimgrep <C-r>/ %<CR> \| :copen <CR>

    " search/substitute
    vnoremap S :s///gc<Left><Left><Left><Left>
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
    Plug 'jiangmiao/auto-pairs'                                             " auto pair brackets, parens, quotes
    Plug 'tpope/vim-surround'                                               " auto surround brackets, parens, quotes
    Plug 'Yggdroot/indentLine'                                              " display the indention levels with thin vertical lines
    Plug 'tpope/vim-fugitive'                                               " git helper for vim
    Plug 'scrooloose/nerdcommenter'                                         " comment helper
    Plug 'godlygeek/tabular'                                                " text alignment
    Plug 'yegappan/mru'                                                     " Most Recently Used (MRU)
    Plug 'SirVer/ultisnips'                                                 " ultimate snippet solution for Vim
    Plug 'FooSoft/vim-argwrap'                                              " wrap/unwrap arguments
    Plug 'lervag/vimtex', { 'for': 'tex' }                                  " plugin for editing LaTeX files
    Plug 'PietroPate/vim-tex-conceal', { 'for': 'tex' }                     " Improved conceal for tex in vim
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " markdown previewer with node.js
    Plug 'skywind3000/asyncrun.vim'                                         " run shell asynchronously and output to quickfix
    Plug 'mattn/emmet-vim', { 'for': 'html,jinja' }                         " provides support for expanding abbreviations similar to emmet
    Plug 'cespare/vim-toml'                                                 " toml syntax
    Plug 'AndrewRadev/switch.vim'                                           " switch segments of text with predefined replacements
    Plug 'gutenye/json5.vim', { 'for': 'json5' }                            " syntax for json5
    Plug 'haya14busa/incsearch.vim'                                         " improved incremental searching for Vim
    Plug 'mboughaba/i3config.vim'                                           " i3 syntax highlight
    Plug 'tyru/open-browser.vim'                                            " open url
    Plug 'JuliaEditorSupport/julia-vim', { 'for': 'julia' }
    Plug 'junegunn/limelight.vim'
    Plug 'kalekundert/vim-coiled-snake', { 'for': 'python' }                " python auto folding,
    Plug 'Konfekt/FastFold'
    Plug 'majutsushi/tagbar'
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }                            " rust's official vim support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    Plug 'ervandew/supertab'                                                " perform completion with Tab
    Plug 'jpalardy/vim-slime', { 'for': 'julia,python' }
    Plug 'ron-rs/ron.vim'

    call plug#end()

    " { Deprecated } {{{
        " Plug 'Lokaltog/neoranger'                                               " integrate ranger with vim
        " Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }              " python completion for deoplete via jedi
        " Plug 'racer-rust/vim-racer', { 'for': 'rust' }                          " Racer support for Vim
        " Plug 'davidhalter/jedi-vim', { 'for': 'python' }                        " jedi autocompletion library
        " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }           " dark powered asynchronous completion framework
        " Plug 'neomake/neomake'                                                  " asynchronous linting and make framework
        " Plug 'autozimu/LanguageClient-neovim', {
        "     \ 'branch': 'next',
        "     \ 'do': 'bash install.sh',
        "     \ }
    " }}}

" }}}

" { Plugins config } {{{
    " { rust.vim } {{{
        let g:rust_fold = 2
    " }}}

    " { vim-slime } {{{
        let g:slime_target = "tmux"
        let g:slime_default_config = {"socket_name": "default", "target_pane": "2"}
        xmap <C-CR> <Plug>SlimeRegionSend
        nmap <C-CR> <Plug>SlimeLineSend
    " }}}

    " { julia } {{{
        let g:latex_to_unicode_auto = 1
        autocmd FileType julia let b:coc_suggest_disable = 1

        " let g:default_julia_version = '1.0'
        " let g:latex_to_unicode_tab = 0
        " let g:latex_to_unicode_cmd_mapping = ['<c-e>']
        " set omnifunc=syntaxcomplete#Complete
        " autocmd FileType julia setlocal omnifunc=LaTeXtoUnicode#omnifunc
    " }}}

    " { coc.nvim } {{{
        setlocal statusline^=%{coc#status()}

        " GoTo code navigation.
        nmap gd       <Plug>(coc-definition)
        nmap gt       <Plug>(coc-type-definition)
        nmap gr       <Plug>(coc-references)
        nmap <Space>r <Plug>(coc-rename)

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Use K to show documentation in preview window.
        nnoremap K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Show all diagnostics.
        nnoremap <silent><nowait> <space>od  :<C-u>CocList diagnostics<cr>
        " Manage extensions.
        nnoremap <silent><nowait> <space>oe  :<C-u>CocList extensions<cr>
        " Show commands.
        nnoremap <silent><nowait> <space>oc  :<C-u>CocList commands<cr>
        " Find symbol of current document.
        nnoremap <silent><nowait> <space>oo  :<C-u>CocList outline<cr>
        " Search workspace symbols.
        nnoremap <silent><nowait> <space>os  :<C-u>CocList -I symbols<cr>

        " { Deprecated: the following implementations have been moved to SuperTab } {{{
            " " use <tab> for trigger completion and navigate to the next complete item
            " function! s:check_back_space() abort
            "     let col = col('.') - 1
            "     return !col || getline('.')[col - 1]  =~ '\s'
            " endfunction

            " inoremap <silent><expr> <Tab>
            "     \ pumvisible() ? "\<C-n>" :
            "     \ <SID>check_back_space() ? "\<Tab>" :
            "     \ coc#refresh()
            " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
            " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        " }}}

    " }}}

    " { open-browser } {{{
        " Disable netrw gx mapping.
        let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
        nmap gx <Plug>(openbrowser-open)
        vmap gx <Plug>(openbrowser-open)
    " }}}

    " { Tagbar } {{{
        nnoremap <silent> <F1> :TagbarToggle<CR>
        inoremap <silent> <F1> <ESC>:TagbarToggle<CR>
        let g:tagbar_compact          = 1
        let g:tagbar_autoclose        = 1
        let g:tagbar_autofocus        = 1
        let g:tagbar_left             = 1
        let g:tagbar_width            = 40
        let g:tagbar_sort             = 0
        let g:tagbar_show_linenumbers = 1
    " }}}

    " { limelight.vim } {{{
        let g:limelight_conceal_ctermfg = 'gray'
        let g:limelight_conceal_ctermfg = 240
        let g:limelight_paragraph_span  = 0
        let g:limelight_default_coefficient = 0.5
        nmap <Space>cl :Limelight!!<CR>
        xmap <Space>cl <Plug>(Limelight)
    " }}}


    " { insearch } {{{
        let g:incsearch#auto_nohlsearch = 1
        nmap /  <Plug>(incsearch-forward)
        nmap ?  <Plug>(incsearch-backward)
        nmap n  <Plug>(incsearch-nohl-n)
        nmap N  <Plug>(incsearch-nohl-N)
    " }}}

    " { swithc.vim } {{{
        let g:switch_mapping = "<C-t>"
        let g:switch_custom_definitions =
            \ [
            \   [1, 0],
            \ ]
    " }}}

    " { vimtex } {{{
        " viewer
        let g:vimtex_view_method = 'zathura'
        let g:vimtex_compiler_progname = 'nvr'

        let maplocalleader = ";"

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

    " { vim-argwrap } {{{
        nnoremap <silent> <Space>a :ArgWrap<CR>
        let g:argwrap_tail_comma = 1
    " }}}

    " { ultisnips } {{{
        let g:UltiSnipsExpandTrigger="<c-e>"
        let g:UltiSnipsJumpForwardTrigger="<CR>"
        let g:UltiSnipsJumpBackwardTrigger="<S-CR>"
        " let g:UltiSnipsJumpForwardTrigger="<c-j>"
        " let g:UltiSnipsJumpBackwardTrigger="<c-k>"
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
            \ 'json5':{'left':'//'},
            \ 'python':{'left':'#'},
            \ 'arduino':{'left':'//'}
        \ }

        " press Backspace to toggle commenter
        nmap <BS> <plug>NERDCommenterToggle
        vmap <BS> <plug>NERDCommenterToggle

    " }}}

    " { vim-surround } {{{
        let g:surround_no_mappings = 1
        nmap ds <Plug>Dsurround
        nmap cs <Plug>Csurround
        xmap s  <Plug>VSurround
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

    " { auto-pairs } {{{
        let g:AutoPairsShortcutBackInsert = ''                     " disable
    " }}}

    " { vim-airline } {{{
        set laststatus=2                                           " set status line
        let g:airline#extensions#tabline#enabled = 1               " displays all buffers when there's only one tab open
        let g:airline#extensions#bufferline#enabled = 1
        let g:airline_powerline_fonts = 1                          " enable powerline-fonts
        let g:airline#extensions#tabline#fnamemod = ':t'           " show file name only
        let g:airline#extensions#tabline#show_tab_nr = 1
        let g:airline#extensions#tabline#tab_nr_type = 1
        let g:airline#extensions#tabline#buffer_idx_mode = 1
        let g:airline#extensions#whitespace#enabled = 0            " disable whitespace check
        let g:airline#extensions#fzf#enabled = 0                   " disable fzf

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

    " { emmet-vim } {{{
        let g:user_emmet_leader_key=','
    " }}}

    " { supertab } {{{
        " make completion from top to bottom
        let g:SuperTabDefaultCompletionType = "<C-n>"
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " }}}

    " { Depracted } {{{

    " " { jedi-vim } {{{
    "     " disable jedi default completion, use depolete-jedi at below instead
    "     let g:jedi#auto_vim_configuration = 0
    "     let g:jedi#completions_enabled = 0
    "     let g:jedi#popup_on_dot = 0
    "     let g:jedi#smart_auto_mappings = 1

    "     " key mappings
    "     let g:jedi#goto_command = "gd"
    "     let g:jedi#documentation_command = "K"
    " " }}}

    " " { LanguageClient-neovim } {{{
    "     let g:LanguageClient_autoStart = 1
    "     let g:LanguageClient_serverCommands = {
    "     \ 'rust': ['/usr/bin/rustup', 'run', 'nightly', 'rls'],
    "     \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    "     \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    "     \ 'python': ['/bin/pyls'],
    "     \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    "     \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    "     \       using LanguageServer;
    "     \       using Pkg;
    "     \       import StaticLint;
    "     \       import SymbolServer;
    "     \       env_path = dirname(Pkg.Types.Context().env.project_file);
    "     \       debug = false;
    "     \
    "     \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "");
    "     \       server.runlinter = true;
    "     \       run(server);
    "     \ ']
    "     \ }

    "     let g:LanguageClient_useVirtualText = "No"

    "     nnoremap <F12> :call LanguageClient_contextMenu()<CR>
    "     " Or map each action separately
    "     nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    "     nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    " " }}}

    " " { neomake } {{{
    "     " disable error after text
    "     let g:neomake_virtualtext_current_error=0

    "     " auto display the error list
    "     let g:neomake_open_list = 2

    "     " limit the error list in 5 lines height
    "     let g:neomake_list_height = 5

    "     call neomake#configure#automake('w')

    "     " for python
    "     let g:neomake_python_enabled_makers = ['flake8', 'mypy']

    "     " TODO: for tex
    "     " let g:neomake_tex_enabled_makers = ['chktex', 'rubberinfo', 'proselint']
    " " }}}

    " " { depolete } {{{
    "     let g:deoplete#enable_at_startup = 1

    "     " TODO: show information
    "     " press <F10> to toggle deoplete
    "     nnoremap <F10> :call deoplete#toggle()<CR>
    "     inoremap <F10> :call deoplete#toggle()<CR>

    "     " ignore errors
    "     let g:deoplete#sources#jedi#ignore_errors = v:true
    "     let g:deoplete#sources#rust#ignore_errors = v:true
    "     call deoplete#custom#option('check_stderr', v:false)
    " " }}}

    " " { vim-racer } {{{
    "     let g:racer_experimental_completer = 1  " show the complete function definition
    "     let g:racer_insert_paren = 1            " insert the parenthesis in the completion
    "     let g:racer_cmd = "/usr/bin/racer"
    "     autocmd FileType rust nmap <buffer> gd <Plug>(rust-def)
    "     autocmd FileType rust nmap <buffer> K <Plug>(rust-doc)
    " " }}}

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
    autocmd WinEnter * if &buftype ==# 'quickfix' && winnr('$') == 1 | bdelete | endif

    function! QuitOrBufferDelete()
        let buf_len = (len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1)
        let empty_name = (expand('%') == '')
        if (buf_len && empty_name)
            exec 'q'
        else
            exec 'bd'
        endif
    endfunction
    nnoremap <silent> <Space>q :call QuitOrBufferDelete()<CR>
" }}}

" { Key mappings } {{{
    " view in middle while editing
    inoremap zz <C-o>zz

    " macros
    nnoremap T qt
    nnoremap t @t

    " jump between changes and view in middle
    nnoremap g; g;zz
    nnoremap g, g,zz
    nnoremap <C-o> <C-o>zz

    " number increment: press <C-s>/<C-x> to increase/decrease 1
    nnoremap <C-s> <C-a>
    vnoremap <C-s> <C-a>

    " redo/undo
    " nnoremap U <C-r>zz
    " nnoremap u uzz
    " inoremap uu <Esc>uzz

    nnoremap U <C-r>
    inoremap uu <Esc>u

    " visual selection
    nnoremap vv <C-v>
    " select last pasted
    nnoremap gp `[v`]
    vnoremap <C-k> 5k
    vnoremap <C-j> 5j

    " Text editing
    inoremap aa <C-o>a

    " yy yank a line with line break, and Y yank a plain line
    nnoremap Y y$

    " { vimrc } {{{
        nnoremap <Space>ve :e $MYVIMRC<CR>
        nnoremap <Space>vv :source $MYVIMRC<CR>
        nnoremap <Space>vi :source $MYVIMRC<CR> :PlugInstall<CR>
        nnoremap <Space>vc :source $MYVIMRC<CR> :PlugClean<CR>
    " }}}

    " { Movement with in line } {{{
        " begining & end
        nnoremap B ^
        nnoremap E $
        vnoremap B ^
        vnoremap E $h

        " emacs-like
        inoremap <M-f> <C-o>w
        inoremap <M-b> <C-o>b
        inoremap <C-a> <C-o>I
        cnoremap <C-f> <Right>
        cnoremap <C-o> <C-f>
        cnoremap <C-b> <Left>
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
        " inoremap <C-k> <Esc><C-u>
        " inoremap <C-j> <Esc><C-d>
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
    nnoremap <Space><Tab> :b#<CR>

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
    " nnoremap <Tab>        <C-w><C-p>
    nnoremap <Space>e     <C-w><C-p>

    " split window
    set splitbelow splitright " specify the location
    nnoremap <Space>s :vsp \| b<Space>

" }}}

" { Location list } {{{
    function! ToggleLocationList(height)
        let n1 = winnr("$")
        exec "lwindow " . a:height
        let n2 = winnr("$")
        if n1 == n2
            lclose
        endif
    endfunction

    " Toggle location list
    nnoremap <silent> <F2> :call ToggleLocationList(5)<CR>
    nnoremap <silent> <Space>t :call ToggleLocationList(5)<CR>
    inoremap <silent> <F2> <Esc>:call ToggleLocationList(5)<CR>
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
