# warning before run
echo "make sure new root is mounted at /mnt before running this"
read i

for s in tasks/*.sh ;do
	sh $s || exit
done

# rest
echo "
job left for you:
	arch-chroot into /mnt, then
	change hostname in /etc/hostname
	set passwd
	install and config bootloader
	run 'locale-gen'          if you changed locale
	run 'mkinitcpio -p linux' if you changed sth about mkinitcpio
  enable following services:
    - sshd
    - ntpdate
    - smartd
    - cronie
    - docker
    - dhcpcd @ (NIC)
    -




"
