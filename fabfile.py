#! /usr/bin/env python2
# -*- coding: utf-8 -*-

"""pyspark"""

from fabric.api import local

def git():
    """Setup Git"""

    local("git remote rm origin")
    local("git remote add origin https://korniichuk@github.com/JohnSnowLabs/pyspark.git")
    local("git remote add private https://korniichuk@github.com/korniichuk/pyspark.git")
