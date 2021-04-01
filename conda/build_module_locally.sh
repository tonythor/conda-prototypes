#!/bin/bash
# Run this from within your module directory, like:
# pwd
# directly within the -common folder.

die() {
  echo "$@" 1>&2
  exit 1
}

OUT_PREFIX="--+-"
MODULE=$(basename "`pwd`")
PROTO_CONDA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROTO_PROJECT_DIR=$(echo $PROTO_CONDA_DIR | sed 's/\/conda$//')
PROTO_CONDA_CACHE=$PROTO_CONDA_DIR/env
MODULE_CACHE=$PROTO_CONDA_CACHE/$MODULE
echo $OUT_PREFIX running $0
echo "$OUT_PREFIX $(date '+%H:%M:%S'): building env '$MODULE'"
echo $OUT_PREFIX Module build directory is: $MODULE
echo $OUT_PREFIX Project directory is: $PROTO_PROJECT_DIR
echo $OUT_PREFIX Conda Cache Directory is: $PROTO_CONDA_CACHE
echo $OUT_PREFIX Module Cache directory is: $MODULE_CACHE

## blast the cache if it exists, maybe add a -b --blast flag later.
if [ -d "$MODULE_CACHE" ]
then
    echo "$OUT_PREFIX Module directory exists, wipe and rebuild from source tree."
    rm -r "$MODULE_CACHE" &>/dev/null
else
    echo "$OUT_PREFIX Cache directory does not exist, build from scratch."
fi

# we need an envrionment.yml file.
if [ -e "environment.yml" ]
  then
    #overwrite module with env.yml name instead of directory"
    MODULE=$(head -n 1 environment.yml | cut -f2 -d ' ')
    echo "$OUT_PREFIX Module name to build (from YML) is $MODULE"
  else
    die "$OUT_PREFIX No environment.yml file, this is not a  conda module."
fi

## Make sure they have bash and zsh routines in their profiles.
## it doesn't overwrite anything, just puts it in there if it's not there already

conda init bash &>/dev/null;


conda env create $MODULE --prefix $MODULE_CACHE -q
conda config --set env_prompt '({name})'

## copy over the defaults

echo "$OUT_PREFIX copying  default files into conda cache"
cp -r $PROTO_CONDA_DIR/fs_defaults/* $MODULE_CACHE/.

## copy down the default includes.
if [ -d "conda_includes" ]; then
  echo "$OUT_PREFIX copying project specfic conda includes into cache folder"
  cp -r ./conda_includes/* $MODULE_CACHE/.
fi

  if [ -d "$PROTO_CONDA_DIR/lib/" ]; then
    echo "$OUT_PREFIX we will be adding spark jars from lib directory"
  else
    echo "$OUT_PREFIX no lib directory and no jars, downloading now"
    "$_CONDA_DIR"/_download_hadoop_jars.sh
fi

conda activate $MODULE_CACHE
echo "copying jars: $PROTO_CONDA_DIR_CONDA_DIR/lib/*.jar $SPARK_HOME/jars/"


cp -r $PROTO_CONDA_DIR/lib/*.jar $SPARK_HOME/jars/.
echo "$OUT_PREFIX  $(date '+%H:%M:%S'): '$MODULE' built and installed using conda."
echo "$OUT_PREFIX leaving install directory. To conda activate using conda_auto_env, you have to change directory back into your module."
cd $PROTO_PROJECT_DIR
