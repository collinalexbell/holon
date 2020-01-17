#!/bin/bash
ps -A | grep pocketsphinx_continuous | grep -v grep | awk '{print $1}'
ps -A | grep launch_sphinx.sh | grep -v grep | awk '{print $1}'
