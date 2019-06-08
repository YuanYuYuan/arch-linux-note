" Async run tex compiling and reloading
function! TexAutoReload()
    exec ":AsyncStop!"
    sleep 100m
    exec ":AsyncRun! ~/Workings/scripts/tex-autoreload.sh %"
endfunction
nnoremap <silent> <F3> :call TexAutoReload()<CR>
inoremap <silent> <F3> <ESC>:call TexAutoReload()<CR>

" vim tex config
inoremap $ $$<ESC>i
autocmd  VimLeave *.tex silent :!latexmk -c

" complete \begin{...} and \end{...}
inoremap <C-b> <Esc>YpkI\begin{<Esc>A}<Esc>jI\end{<Esc>A}<Esc>ko
nnoremap <C-b> YpkI\begin{<Esc>A}<Esc>jI\end{<Esc>A}<Esc>ko
vnoremap <C-b> YpkI\begin{<Esc>A}<Esc>jI\end{<Esc>A}<Esc>ko

" select with indent
" function SelectIndent()
"     let cur_line = line(".")
"     let cur_ind = indent(cur_line)
"     let line = cur_line
"     while indent(line-1) >= cur_ind
"         let line = line - 1
"     endw
"     exe "normal " . line . "G"
"     exe "normal V"
"     let cur_line = line(".")
"     while indent(line+1) >= cur_ind
"         let line = line + 1
"     endw
"     exe "normal " . line . "G"
" endfunction
" nnoremap vii :call SelectIndent()<CR>

" naviagate in <++>
inoremap <Space><Tab> <Esc>/<++><Enter>c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>c4l
map      <Space><Tab> <Esc>/<++><Enter>c4l

inoremap ;beg  \begin{}<CR>\end{<++>}<Esc>kT{i

inoremap ;tbf \textbf{}<Esc>T{i
inoremap ;tx \text{}<Esc>T{i
inoremap ;bx \boxed{}<Esc>T{i
inoremap ;mbb \mathbb{}<Esc>T{i
inoremap ;mbf \mathbf{}<Esc>T{i
inoremap ;sq  \sqrt{}<Esc>T{i
inoremap ;wh  \widehat{}<Esc>T{i
inoremap ;ex  e^{}<++><Esc>T{i
inoremap ;ei  e^{i}<++><Esc>T{a
inoremap ;fc  \frac{}{<++>}<++><Esc>2T{i
inoremap ;be  \begin{<++>}<CR>\end{<++>}<Esc>kT\
inoremap ;eq  \begin{equation*}<CR>\end{equation*}<Esc>ko
inoremap ;al  \begin{align*}<CR>\end{align*}<Esc>ko<Tab>
inoremap ;en  \begin{enumerate}<CR>\end{enumerate}<Esc>ko
inoremap ;Mp  \begin{pmatrix}<CR>\end{pmatrix}<Esc>ko
inoremap ;Mb  \begin{bmatrix}<CR>\end{bmatrix}<Esc>ko
inoremap ;sm  \sum_{}^{<++>}<Esc>2T{i
inoremap ;it  \int_{}^{<++>}<Esc>2T{i
inoremap ;te  \triangleq<Space>

" notation
inoremap ;bec \because
inoremap ;the \therefore
inoremap ;\\ <Esc>A\\<CR>

" arrow
inoremap ;ra  \rightarrow<Space>
inoremap ;Ra  \Rightarrow<Space>
inoremap ;la  \leftarrow<Space>
inoremap ;La  \Leftarrow<Space>

" greek alphabet
inoremap ;ga  \alpha
inoremap ;gb  \beta
inoremap ;gd  \delta
inoremap ;gD  \Delta
inoremap ;ge  \varepsilon
inoremap ;gi  \phi
inoremap ;gI  \Phi
inoremap ;gl  \lambda
inoremap ;gL  \Lambda
inoremap ;gh  \theta
inoremap ;gH  \Theta
inoremap ;gm  \mu
inoremap ;gn  \nu
inoremap ;go  \omega
inoremap ;gO  \Omega
inoremap ;gg  \gamma
inoremap ;gG  \Gamma
inoremap ;gp  \pi
inoremap ;gr  \rho
inoremap ;gs  \sigma
inoremap ;gS  \Sigma
inoremap ;gx  \xi

" math set
inoremap ;Sr \mathbb{R}<Space>
inoremap ;Sq \mathbb{Q}<Space>
inoremap ;Sz \mathbb{Z}<Space>
inoremap ;Sn \mathbb{N}<Space>
