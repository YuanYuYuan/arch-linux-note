vboxmanage controlvm arch_test poweroff
vboxmanage unregistervm arch_test --delete
./create_arch_vm.sh arch_test 2048 10000 /home/circle/Downloads/archlinux-2017.01.01-dual.iso

echo 'wait for run the ssh service and set the passwd in guest vm ... '
read
echo '==============start ssh and scp=============='
rm ~/.ssh/known_hosts
scp -P 3022 ranked_mirrorlist arch_installation_script.sh root@localhost:/root
ssh -p 3022 root@localhost

