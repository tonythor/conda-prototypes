#!/bin/bash

project=$(pwd)
module=FALSE
conda_clean=FALSE

for arg in "$@"
do
    case $arg in
        -m=*|--module=*)
          module="${arg#*=}"
          mod_dir=$project/$module
          shift
        ;;
        -c|--conda_clean)
          conda_clean=TRUE
          shift
        ;;
    esac
done

usage() {
  echo "## Blast all the caches and prep for github commit."
  echo "$0 -m=module     (wipes out all cache setuptools)"
  echo "$0 -m=module -c  (cleans, also blasts conda cache)"
}



die() {
  echo "$@" 1>&2
  exit 1
}

if [ "${module}" == "FALSE" ]; then
    usage
    die '!! please pass in in a --module={module} this command.'
fi

#just double check, don't go passing -r flags willie nilly!!
[ ! -d "$mod_dir" ] && die "-> module directory does not exist"

#remove all the extra stuff from pyscaffold
rm -r $mod_dir/build/* &>/dev/null
rmdir $mod_dir/build &>/dev/null
rm -r $mod_dir/dist/* &>/dev/null
rmdir $mod_dir/dist &>/dev/null
rm    $mod_dir/src/*.egg-info/* &>/dev/null
rmdir $mod_dir/src/*.egg-info &>/dev/null
rm -r $mod_dir/.eggs/ &>/dev/null
rmdir $mod_dir/.eggs &>/dev/null
rm -r $mod_dir/.coverage* &>/dev/null
rm -r $mod_dir/.pytest_cache &>/dev/null
rm -r $mod_dir/htmlcov &>/dev/null

#blast conda cache if necessary
if [ "${conda_clean}" == "TRUE" ]; then
    rm -r  ./conda/env/"$module/"  &>/dev/null
fi

echo "-> cleaned"



