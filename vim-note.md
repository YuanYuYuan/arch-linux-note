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





