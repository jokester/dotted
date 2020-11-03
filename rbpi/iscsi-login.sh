# before login: iscsiadm -m node --target IQN:NAME --portal 192.168.2.100 -o new
iscsiadm -m node --target IQN:NAME --portal 192.168.2.100 --login
