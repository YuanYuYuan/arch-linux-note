#! /bin/bash

if [[ $1 == "" ]]; then
    echo
    echo -n "VM_name > "
    read vm_name
else
    vm_name=$1
fi

echo
echo "create $vm_name vm ... "
vboxmanage createvm --name $vm_name --register

if [[ $2 == "" ]]; then
    echo
    echo -n "specify memory size (MB) > "
    read memory_size
else
    memory_size=$2
fi

echo "modify vm with $memory_size MB memory ... "
vboxmanage modifyvm $vm_name --memory $memory_size --acpi on --firmware efi \
    --vram 256 --accelerate3d on --accelerate2dvideo on --boot1 dvd \
    --nic1 nat --natpf1 "guest_ssh,tcp,,3022,,22" --rtcuseutc on \
    --cableconnected1 on --ostype ArchLinux_64

if [[ $3 == "" ]]; then
    echo
    echo -n "specify vdi size (MB) >  "
    read vdi_size
else
    vdi_size=$3
fi

echo
echo "create vdi at ~/VirtualBox VMs/$vm_name/ with size $vdi_size"
vboxmanage createvdi --filename ~/VirtualBox\ VMs/$vm_name/${vm_name}_disk.vdi --size $vdi_size


echo
echo "create sata storage controller ... "
vboxmanage storagectl $vm_name --name ${vm_name}_sata_controller --add sata
vboxmanage storageattach $vm_name --storagectl ${vm_name}_sata_controller --port 0 --device 0 \
    --type hdd --medium ~/VirtualBox\ VMs/$vm_name/${vm_name}_disk.vdi


if [[ $4 == "" ]]; then
    echo
    echo -n "specify iso location > "
    read iso_location
else 
    iso_location=$4
fi

echo
echo "create ide storage controller ... "
vboxmanage storagectl $vm_name --name ${vm_name}_ide_controller --add ide
vboxmanage storageattach $vm_name --storagectl ${vm_name}_ide_controller --port 0 --device 0 \
    --type dvddrive --medium $iso_location

echo "finished!"

vboxmanage startvm $vm_name
