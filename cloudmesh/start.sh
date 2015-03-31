#!/usr/bin/env bash

# IMPORTANT
#
# This script starts all the cloudmesh processes
#
# You need
# - cloudmeshdir=[cloudmesh] : location of cloudmesh source (default=./cloudmesh)
#
#


############################################################ variables
my_cloudmesh_dir=$cloudmeshdir

############################################################ error codes
error_not_venv=1
error_no_cm=2
error_missing_cm_repo=3

############################################################ sanity checks

#### we assume a virtual env is activated and cloudmesh is installed.
#### check that this is the case

### check that this is a venv
### the python program exits 0 if running in venv
isvenv='import sys;sys.exit(0 if hasattr(sys, "real_prefix") else 1)'
if ! python -c "$isvenv"; then
    echo "ERROR: virtual environment not detected"
    exit $error_not_venv
fi

### check that cloudmesh is installed
if ! which cm >/dev/null 2>&1; then
    echo "ERROR: cloudmesh is not installed"
    exit $error_no_cm
fi

if [ -z $my_cloudmesh_dir ]; then
    my_cloudmesh_dir=cloudmesh
    echo "WARNING: using default cloudmesh=$my_cloudmesh_dir"
fi

if [ ! -d $my_cloudmesh_dir ]; then
    echo "ERROR: could not find cloudmesh in $my_cloudmesh_dir"
    exit $error_missing_cm_repo
fi

############################################################ tracing and errors
set -o xtrace
set -o errexit

############################################################ all is good

cd $my_cloudmesh_dir

fab server.start

# view options
cm cloud list
cm cloud on india
cm flavor india --refresh
