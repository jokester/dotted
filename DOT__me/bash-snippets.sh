#!/bin/bash

set -ue

echo "not executable"
exit 1

git-commit-abbr-jenkins () {
  local COMMIT_ABREV="${GIT_COMMIT:0:6}" # substr(0, 6)
  echo -n $COMMIT_ABREV
}

git-branch-name-jenkins () {
  local BUILD_BRANCH="${GIT_BRANCH/*\//}" # strip until first slash
}

require-in-path () {
 : 
}

disk-test () {
  # run badblocks (r/w) to check error
  # WARNING this overwrites existing data
  badblocks -wsv /dev/sdc


  # show SMART stats
  smartctl -AH /dev/ad3

  # TODO: run SMART start
}

disk-rescue () {
  # attempt to dump vdb1 to vdb1.img
  ddrescue /dev/vdb1 vdb1.img vdb1.ddrescue.map
}

zsh-cd-hook-example () {
  # the following code should be `source`d in every zsh session.
  # currently it only uses path of repo, we could as well use hostname and stuff

  __zsh-on-cd () {
  if git ls-files &>/dev/null ; then
    if [[ "$PWD" =~ 'Company-repos' ]]; then
      echo "setting git to use work identity"
      git config user.name "mii mii"
      git config user.email "ME@company.com"
    else
      echo "setting git to use personal identity"
      git config user.name "Wang Guan"
      git config user.email "momocraft@gmail.com"
    fi
  fi
  }

  # execute the 
  chpwd_functions=(${chpwd_functions[@]} "__zsh-on-cd")

}

