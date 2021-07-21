#!/bin/bash

### Usage:
# ./package.sh -m=tf-common -t -s -c
#  where -t is run tests, -s is push to server and -c is clean when done.

TAG=`date "+%Y%m%d%H%M"` 
echo "Tagging:"
git add -A
git commit -m "rebuilding everything"
git tag -a v0.0."$TAG" -m"0.0.$TAG"

export PATH=$PATH:.
pwd=$(pwd)
push=""
run_tests=FALSE

for arg in "$@"
do
    case $arg in
        -m=*|--module=*)
          module="${arg#*=}"
          conda_dir=$pwd/conda/env/$module
          module_dir=$pwd/$module
          #for conda activate init.d
          export MODULE=$module
          shift
        ;;
        -s|--pushToServer)
          echo "-> also pushing to remote server"
          pushToServer=" upload -r pypilocal"
          shift
        ;;
        -t|--runTests)
          run_tests=TRUE
          shift
        ;;
    esac
done

die() {
  echo "$@" 1>&2
  exit 1
}

if [ "${module}" == "FALSE" ]; then
    die '-> please pass in in a --module={module} this command.'
fi

### uninstall module if installed.
echo "-> uninstalling $module"
pip3 uninstall $module -y

### run tests
if [ "${run_tests}" == "TRUE" ]
then

  if [ ! -d "$conda_dir" ] ; then
    die "!! conda env is not built. pls build trying to run activate and run tests."
  fi

  echo "-> running tests"
  if [ "${SHELL}" == "/bin/zsh" ]; then
    . ~/.zshrc
  elif [ "${SHELL}" == "/bin/bash" ]; then
    . ~/.bash_profile
  else
      die "!!  pls use bash or zsh, or roll your own version of package.sh."
  fi
  #Now we need to conda activate for testing.

  conda activate $conda_dir
  ## make sure we're in the right place, and run the tests.
  cd $module_dir
  python3 setup.py test
fi

## build and maybe push a wheel file.
### You want this output install to site-packages directory, otherwise it's a mess.
### To get that, make sure you don't have your current path in PYTHONPATH.
### just remember to put it back in case you need it elsewhere.

PP=$PYTHONPATH
unset PYTHONPATH
echo "-> building $mod"
cd $module_dir
python3 setup.py --verbose bdist_wheel $pushToServer
new_mod=$(find ./dist/*.whl |sed 's/\.\///g')
## install module if you want it locally, not advised if you use conda.
# pip3 install $new_mod
export PYTHONPATH=$PP

#Go back to the root and clean.
cd $pwd
# ./clean.sh -m=$module
echo "-> packaged"
