.. contents:: Table of contents
   :depth: 2

Short Description
=================
Apache PySpark

Full description
================
The `ubuntu:xenial <https://hub.docker.com/r/_/ubuntu/>`_ Docker image with Apache PySpark for the dataops utility.

GitHub
======
The `korniichuk/pyspark <https://github.com/korniichuk/pyspark>`_ repo.

Docker Hub
==========
The `korniichuk/pyspark <https://hub.docker.com/r/korniichuk/pyspark/>`_ repo.

Quickstart
==========
Bash
----
Start a container with interactive Bash shell::

    $ docker run -it korniichuk/pyspark bash

PySpark
-------
Start a container with interactive PySpark shell::

    $ docker run -it korniichuk/pyspark \
            /usr/local/src/spark-2.1.0-bin-hadoop2.7/bin/pyspark

Try the following command, which should return 1000::

    >>> sc.parallelize(range(1000)).count()

Python
------
Start a container with interactive Python shell::

    $ docker run -it korniichuk/pyspark python
    >>> from pyspark import SparkConf, SparkContext
    >>> conf = SparkConf().setMaster("local[*]")
    >>> sc = SparkContext(conf=conf)

And run the following command, which should also return 1000::

    >>> sc.parallelize(range(1000)).count()
