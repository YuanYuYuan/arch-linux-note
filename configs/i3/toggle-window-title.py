import i3ipc
i3 = i3ipc.Connection()
focused = i3.get_tree().find_focused()
if focused.border == 'none':
    i3.command('border normal')
else:
    i3.command('border none')
