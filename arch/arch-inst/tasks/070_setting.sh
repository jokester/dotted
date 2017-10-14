echo "setting: locale-gen"
arch-chroot /mnt mkinitcpio -p linux
echo "enabling systemd services"
arch-chroot /mnt systemctl enable cronie
arch-chroot /mnt systemctl enable smartd
arch-chroot /mnt systemctl enable thermald
arch-chroot /mnt systemctl enable dhcpcd
arch-chroot /mnt systemctl enable ntpdate
