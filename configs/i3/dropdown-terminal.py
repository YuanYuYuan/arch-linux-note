import i3ipc
i3 = i3ipc.Connection()
dropdown = i3.get_tree().find_instanced("dropdown")
if len(dropdown):
    i3.command("[instance=\"dropdown\"] scratchpad show")
else:
    i3.command("exec --no-startup-id termite --name=dropdown")
