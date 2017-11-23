# list leaf packages (that are not dependency of other packages)
pkg query "%?r\t%n" | grep "^0" |cut -f2

# free
top -d1 | head -5

# lsusb @ linux
usbconfig

# lspci
pciconf -lv

# lsblk
camcontrol devlist

