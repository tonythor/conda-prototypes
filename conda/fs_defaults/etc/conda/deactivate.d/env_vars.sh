unset PYTHONPATH
unset PYSPARK_DRIVER_PYTHON
unset PYSPARK_PYTHON
unset SPARK_HOME

if [ -f ./local.sh ]; then
    echo "-- setting local.sh variables."
    source ./local.sh
fi