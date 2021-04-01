#!/bin/bash
## extended from this: https://github.com/chdoig/conda-auto-env

PROTO_CONDA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROTO_CONDA_CACHE=$PROTO_CONDA_DIR/env/
PROTO_PROJECT_DIR=$(echo $PROTO_CONDA_DIR | sed 's/\/conda$//')
export BASH_SILENCE_DEPRECATION_WARNING=1
export PYTHONWARNINGS='ignore:resource_tracker:UserWarning'

function conda_auto_env() {
  ## you don't need to do this for bash.

  if [ -e "environment.yml" ]; then
    # environment.yml file found, the the module name.
    MODULE=$(head -n 1 environment.yml | cut -f2 -d ' ')
    ## do this export so you can see it in zsh conda activate scripts.
    export MODULE="$MODULE"
    # try to conda activate the this env.yml directory's module. If it doesn't activate,
    # set it up with the setup utility script.
    if [[ $PATH != *$MODULE* ]]; then
      sh=$(basename $SHELL)

      # make sure this conda activate command runs, if it doesn't, then run the build script.
      conda activate $PROTO_CONDA_CACHE/$MODULE &>/dev/null
      if [ $? -eq 0 ]; then
        echo "activated $MODULE module"
        :
      else
        ## It didn't activate, so build it.

        #-> Run bash in --login mode to make sure you pick up .bash_profile and pick up conda init.
        bash -l $PROTO_CONDA_DIR/build_module_locally.sh
        # Make sure you leave the module directory with env.yml, and then force the reload.
        cd $PROTO_PROJECT_DIR
      fi
    fi
  else
    #Shut down conda if you're not in the right directory.
    conda deactivate
  fi
}

#for bash
export PROMPT_COMMAND=conda_auto_env
#for zsh
chpwd_functions+=(conda_auto_env)
