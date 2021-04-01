# because we use pyscaffold, we need to get the classes from this project into the classpath.
# if we didn't, we'd have to do import `src.nbcuas.common.infrastructure...`
# and if we do that, that won't work for pyscaffold.

PV="3.6"


export PYTHONPATH="$PROTO_PROJECT_DIR/conda/env/$MODULE/lib/python$PV/site-packages:$PROTO_PROJECT_DIR/$MODULE/src"
echo "PROTO_PROJECT_DIR : $PROTO_PROJECT_DIR"
echo "PYTHONPATH: $PYTHONPATH"

# we need to set up pyspark. you can pip or conda install it just fine, but that doesn't help
# for running, or for execution.
export PYSPARK_DRIVER_PYTHON=$PROTO_PROJECT_DIR/conda/env/$MODULE/bin/ipython
export PYSPARK_PYTHON=$PROTO_PROJECT_DIR/conda/env/$MODULE/bin/python
export PROTO_PYTHON_SRC_ROOT=$PROTO_PROJECT_DIR/$MODULE/src
export JAVA_HOME=$PROTO_PROJECT_DIR/conda/env/$MODULE
export SPARK_HOME=$PROTO_PROJECT_DIR/conda/env/$MODULE/lib/python$PV/site-packages/pyspark

if [ -f ./local.sh ]; then
    echo "-- setting local.sh variables."
    source ./local.sh
fi
