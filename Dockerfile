# Name: korniichuk/pyspark
# Short Description: Apache PySpark
# Full Description: The ubuntu:xenial Docker image with Apache PySpark
# for the dataops utility.
# Version: 0.1a1

FROM ubuntu:xenial

MAINTAINER Ruslan Korniichuk <ruslan.korniichuk@gmail.com>

USER root

# 1. OS
# Retrieve new lists of packages
ENV OS_REFRESHED_AT 2016-11-11
RUN apt-get -qq update # -qq -- no output except for errors

# 2. APT
# Install g++, wget, pigz
ENV APT_REFRESHED_AT 2016-11-11
RUN apt-get -qq update && apt-get install -y g++ wget pigz && apt-get clean

# 3. JAVA
# Install java
ENV JAVA_REFRESHED_AT 2016-11-11
RUN apt-get -qq update && apt-get install -y openjdk-8* && apt-get clean

# 4. PYTHON+PIP
# Install python, python-dev
ENV PYTHON_REFRESHED_AT 2016-11-11
RUN apt-get -qq update \
        && apt-get install -y python python-dev \
        && apt-get clean
# Download get-pip.py file to '/tmp' directory
ENV PIP_REFRESHED_AT 2016-11-11
RUN wget --directory-prefix /tmp https://bootstrap.pypa.io/get-pip.py
# Install pip
RUN python /tmp/get-pip.py
# Remove '/tmp/get-pip.py' file
RUN rm /tmp/get-pip.py

# 5. SPARK
# Download Apache Spark ver. 2.0.1 (2016-10-03) to '/tmp' directory
ENV URL_SCHEME=http
ENV URL_NETLOC=ftp.ps.pl
ENV URL_PATH=/pub/apache/spark/spark-2.0.1/spark-2.0.1-bin-hadoop2.7.tgz
ENV URL=$URL_SCHEME://$URL_NETLOC$URL_PATH
RUN wget --directory-prefix /tmp $URL
# Unpack '/tmp/spark-2.0.1-bin-hadoop2.7.tgz' archive
RUN unpigz --to-stdout /tmp/spark-2.0.1-bin-hadoop2.7.tgz \
        | tar --extract --file - --directory /home
# Remove '/tmp/spark-2.0.1-bin-hadoop2.7.tgz' archive
RUN rm /tmp/spark-2.0.1-bin-hadoop2.7.tgz
# Set up Apache Spark
ENV SPARK_HOME=/home/spark-2.0.1-bin-hadoop2.7
ENV PYTHON_DIR_PATH=/home/spark-2.0.1-bin-hadoop2.7/python/
ENV PY4J_PATH=/home/spark-2.0.1-bin-hadoop2.7/python/lib/py4j-0.10.3-src.zip
ENV PYTHONPATH=$PYTHON_DIR_PATH:$PY4J_PATH
COPY docker/log4j.properties \
        /home/spark-2.0.1-bin-hadoop2.7/conf/log4j.properties
COPY docker/spark-defaults.conf \
        /home/spark-2.0.1-bin-hadoop2.7/conf/spark-defaults.conf
