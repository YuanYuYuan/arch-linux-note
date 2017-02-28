vm_name=arch_test

vboxmanage controlvm $vm_name poweroff
vboxmanage unregistervm $vm_name --delete
./create_arch_vm.sh $vm_name 2048 10000 /home/circle/Downloads/archlinux-2017.01.01-dual.iso

echo 'wait for run the ssh service and set the passwd in guest vm ... '
read
echo '==============start ssh and scp=============='
rm ~/.ssh/known_hosts
scp -P 3022 ranked_mirrorlist arch_installation_script.sh root@localhost:/root
ssh -p 3022 root@localhost

