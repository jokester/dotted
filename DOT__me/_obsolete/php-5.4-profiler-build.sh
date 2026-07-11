#!/bin/bash
set -ue

build-apache () {
  local prefix="$PWD/local"
  mkdir -pv build
  wget --continue http://www.apache.org/dist/httpd/httpd-2.2.31.tar.bz2 -O build/httpd-2.2.31.tar.bz2
  tar xf build/httpd-2.2.31.tar.bz2 -C build/
  pushd build/httpd-2.2.31
  ./configure --prefix="$prefix" --enable-mods-shared=all
  make -j4
  make install
  popd
}

build-php () {
  local prefix="$PWD/local"
  mkdir -pv build
  wget --continue http://php.net/get/php-5.4.45.tar.bz2/from/this/mirror -O build/php-5.4.45.tar.bz2
  tar xf build/php-5.4.45.tar.bz2 -C build/
  pushd build/php-5.4.45
  ./configure --prefix="$prefix" --with-apxs2="$prefix/bin/apxs" --enable-mbstring --enable-debug
  make -j4
  # make test
  make install
  popd
}

build-apd () {
  local prefix="$PWD/local"
  mkdir -pv build
  wget --continue 'https://pecl.php.net/get/apd-1.0.1.tgz' \
    -O build/apd-1.0.1.tgz
  tar xf build/apd-1.0.1.tgz -C build/
  pushd build/apd-1.0.1
  # a patch for php5.4
  curl https://gist.githubusercontent.com/martinsik/3322159/raw/869422c13a372c689df352b1ce23a42073784680/apd-php54.diff \
    | patch
  "$prefix"/bin/phpize
  ./configure --prefix="$prefix" --with-php-config="$prefix/bin/php-config"
  make
  make test
  make install
  # the following files have to be modified manually
  # - php.ini
  # - pprofp (the #! line)
}

cd "$(dirname "$0")"

build-apache
build-php
build-apd