" naviagate in <++>
inoremap <Space><Tab> <Esc>/<++><Enter>c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>c4l
map      <Space><Tab> <Esc>/<++><Enter>c4l

inoremap ;np   import numpy as np<CR>
inoremap ;pl  import matplotlib.pyplot as plt<CR>

" vim-slime
nmap <CR> <Plug>SlimeLineSend

" Screen Shell
" nnoremap <F3> :!python %<CR>
" nnoremap <F5> :ScreenShell ipython<CR>
" vnoremap <CR> :ScreenSend<CR>
" nnoremap <CR> V:ScreenSend<CR>j
" nnoremap <Space>sq :ScreenQuit<CR>
" nnoremap <Space>sl :call g:ScreenShellSend("clear")<CR>
" nnoremap <Space>s<CR> :call g:ScreenShellSend("\r")<CR>
