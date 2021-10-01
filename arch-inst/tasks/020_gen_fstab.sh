# gen fstab
echo "generate fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab
