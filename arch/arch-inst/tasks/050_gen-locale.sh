echo "patching locale.gen"
echo 'en_US.UTF-8 UTF-8' >> /mnt/etc/locale.gen
echo "running locale-gen"
arch-chroot /mnt locale-gen
