#!/usr/bin/env bash

echo "proceeding will install archlinux into /mnt"
echo "make sure new root is mounted at /mnt before running this"
echo "CTRL-c if you want to stop. enter to continue"
read

set -uex

cd $(dirname "$0")

bash ./tasks/010_inst_packages.sh pkglist_rbpi_basic

bash ./tasks/020_gen_fstab.sh
bash ./tasks/030_set_timezone.sh
bash ./tasks/040_gen_locale.conf.sh
bash ./tasks/050_gen-locale.sh
bash ./tasks/060_hostname.sh

echo "enabling systemd services"
arch-chroot /mnt systemctl enable cronie
arch-chroot /mnt systemctl enable dhcpcd
arch-chroot /mnt systemctl enable ntpd
arch-chroot /mnt systemctl enable smartd

# rest
echo '
job left:
	arch-chroot into /mnt, then
  populate sign key as in https://archlinuxarm.org/about/package-signing
  review /etc/fstab
	change hostname in /etc/hostname
	set passwd
	run 'locale-gen'          if you changed locale
	run 'mkinitcpio -p linux' if you changed sth about mkinitcpio

  set kernel cmd line in /boot/cmdline.txt like:
    root=UUID=THE_UUID rootflags=subvol=/root
'
