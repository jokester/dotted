#!/usr/bin/env bash

echo "installing archlinux into /mnt"
echo "make sure new root is mounted at /mnt before running this"
echo "CTRL-c if you want to stop. enter to continue"
read

set -uex

cd $(dirname "$0")

bash ./tasks/010_inst_packages.sh pkglist_basic
bash ./tasks/020_gen_fstab.sh
bash ./tasks/030_set_timezone.sh
bash ./tasks/040_gen_locale.conf.sh
bash ./tasks/050_gen-locale.sh
bash ./tasks/060_hostname.sh
bash ./tasks/070_setting.sh

# rest
cat <<END
job left for you:
	arch-chroot into /mnt, and

  - review /etc/fstab
  - set hostname (/etc/hostname)
  - set timezone (timedatectl)
  - set root password
	- install and config bootloader
	- setup users and passwords
	- run "locale-gen"          if you changed locale
	- run "mkinitcpio -p linux" if you changed sth about mkinitcpio
END
