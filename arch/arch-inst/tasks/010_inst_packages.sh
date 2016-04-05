# inst packages.sh
echo "install packages"
pacstrap              \
  -C /etc/pacman.conf \
  -c                  \
  /mnt                \
  $(<pkglist_basic)

cp pkglist_* /mnt/root -v
