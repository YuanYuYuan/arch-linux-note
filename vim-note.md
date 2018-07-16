# vim-note

This a note of vim

-----------------------------------------------------

### Write file with super user privilege

```sh
:w !sudo tee %
```

### vim markdown

```sh
TableFormat # format the markdown table
Toc # create a quickfix vertial window of contents of the markdown file
```

### Search selected text

```sh
(visual-mode)y
/
<Ctrl>+R
"
```

### Replace quotes around words, ex: '123', '456' -> "123", "456"

```sh
:s/'\([^']*\)'/"\1"/g
```

### error: Cannot write, 'bufftype' option is set

```sh
:setlocal buftype=
```

###  vim macros

create a macro

```sh
q<letter><commands>
```
execute the macro

```sh
<number>@<letter>
```

| keys | function              |
|------|-----------------------|
| qd   | records to register d |
| q    | stop recording        |
| @d   | execute macro d       |
| @@   | execute again         |


Mapping key to run a macro

```sh
nnoremap <Space> @d
```

Viewing macros

```sh
registers
```

Save in vimrc

```sh
let @d='<commands>'
```

### vim infomation

```sh
:echo $HOME
:echo $VIM
:echo $VIMRUNTIME
```

### get filetype

```sh
:set filetype?
:set ft
```

### format json

```sh
:%!python -m json.tool
```

### folding

```sh
zf{motion} or {Visual}zf #Operator to create a fold.
zf'a # fold to mark
zF :Create a fold for N lines.
zd :Delete one fold at the cursor.
zD :Delete folds recursively at the cursor.
zE :Eliminate all folds in the window.
zo :Open one fold.
zO :Open all folds recursively.
zc :Close one fold.
zC :Close all folds recursively.
za :When on a closed fold: open it.and vice-versa.
zA :When on a closed fold: open it recursively.and vice-versa.
zR :Open all folds.
zM :Close all folds:
zn :Fold none: reset 'foldenable'. All folds will be open.
zN :Fold normal: set 'foldenable'. All folds will be as they were before.
zi :Invert 'foldenable'.

[z :Move to the start of the current open fold.
]z :Move to the end of the current open fold.
zj :Move downwards. to the start of the next fold.
zk :Move upwards to the end of the previous fold.
```





