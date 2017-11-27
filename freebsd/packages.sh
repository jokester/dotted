# pkg install
pkg install \
  `#everyday use#` bash zsh git screen sudo pv vim-lite wget rsync      \
  `#security` gnupg nmap                                                \
  `#dev` ruby devel/ruby-gems cmake                                     \
  `#vm host#`    vm-bhyve grub2-bhyve                                   \
  `#monitoring` htop                           \
  `#log` fluent-bit \
  `#gnu/linux alt` coreutils gmake \
  `#disk related` ddrescue smartmontools zfs-stats e2fsprogs \
  `#device` dmidecode \
  `#cpu microcode` devcpu-data                                          \
  `#needed to forward mail to internet#` sendmail+tls+sasl2 ca_root_nss \
  `#nas server#` samba46                                                \
