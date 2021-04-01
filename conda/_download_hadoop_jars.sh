#!/bin/bash

#This script is part of the conda setup, it downloads jars to SPARK_HOME.
#You need the s3 jars for everything you are going to run pyspark with.

#You can run it now, or you can wait until build locally runs it for you.

rel=$(dirname "$0" )
dir=$( cd "$rel" && pwd )/lib
# echo "making directory $dir for local copy of spark jars "
mkdir  $dir
curl --silent https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar       --output "$dir"/aws-java-sdk-1.7.4.jar
curl --silent https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client/2.7.3/hadoop-client-2.7.3.jar --output "$dir"/hadoop-client-2.7.3.jar
curl --silent https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar       --output "$dir"/hadoop-aws-2.7.3.jar
