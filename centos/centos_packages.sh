#!/bin/bash

# epel
yum install epel-release
# rpmforge
yum install http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

yum update
yum groupinstall "Development Tools" -y
yum install \
  git zsh screen vim htop rsync lftp mlocate pv ntp \
  nmap weechat transmission-daemon wget \
  ruby ruby-devel clang docker python-devel cmake ghc cabal-install \
  yum-utils yum-cron iotop iftop deltarpm bind-utils \
  gnutls-utils rsyslog-gnutls
