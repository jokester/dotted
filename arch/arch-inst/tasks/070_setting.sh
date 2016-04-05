echo "setting"
arch-chroot /mnt locale-gen
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt systemctl enable cronie
arch-chroot /mnt systemctl enable smartd
