#!/usr/bin/bash
merge () {
  local ext=$1
  shift
  for found in `locate $ext`;do
    orig=${found%.${ext}}
    if [ $# -gt 0 ];then
      $1 $orig $found
      rm -i $found
    else
      echo $orig '<->' $found
    fi
  done

}
merge pacnew "$@"
