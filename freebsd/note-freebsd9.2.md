#### 版本
FreeBSD 9.2 i386

#### 基本系统安装:
用写入安装img的u盘启动, 一路next

#### 软件包:
自带一个binary包管理器`pkg`, 见 [freebsd wiki]( https://wiki.freebsd.org/pkgng )

相关概念和linux的包管理器没啥区别.

默认shell是csh.

pkg提供了基本系统不包括的bash zsh vim git perl等. 

#### 基本系统已有的服务:

###### SSH
由openssh提供, 和linux没区别

###### NFS
和linux的NFS的比较:

1. `/etc/exports`格式不同, 需RTFM.
2. 同一个文件系统只能被export**一次** (对应`/etc/exports`中的一行). 可以在一行中export多个目录.

###### FTP
系统自带一个ftpd 我没有试.

#### 另外安装的服务:

因为软件大多是一样的, 和linux没区别的不再一一注明.

包名=`pkg` repo中的包名

###### samba
包名=samba36

###### FTP
包名=vsftpd-ssl

###### HTTP
包名=nginx

###### DLNA
包名=minidlna

#### 服务的管理
开机时启动的服务写在`/etc/rc.conf`, 类似几年前的archlinux

运行中的服务用`service`管理, 类似ubuntu
