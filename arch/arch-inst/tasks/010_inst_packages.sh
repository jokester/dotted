# inst packages.sh
echo "install packages"
pacstrap              \
  -C /etc/pacman.conf \
  /mnt                \
  $(<pkglist_basic)

cp pkglist_* /mnt/root -v
