#!/usr/bin/env bash

# IMPORTANT
#
# This script configures cloudmesh using your FutureSystems portal
# name
#
# You need to set some variables in order for this to work:
# - portalname: your FutureSystems portal id.
# - projectid: your FutureSystems project
# - cloudmeshdir=[./cloudmesh] location of local cloudmesh repo (default=./cloudmesh)
#
# Additionally, make sure the appropriate virtual environment is
# activated
#
# As this connects to futuresystems you will need to have access. If
# you are running this script in Vagrant, make sure that you have
# enabled ssh forwarding using ssh-agent.
#
# Example:
# $ source ~/ENV/bin/activate
# $ curl $URL | portalname=$PORTALNAME projectid=$PROJECTID bash

############################################################ variables
my_portalname=$portalname
my_projectid=$projectid
my_cloudmesh_dir=$cloudmeshdir

############################################################ error codes
error_variables_missing=1
error_not_venv=2
error_no_cm=3
error_missing_cm_repo=4

############################################################ sanity checks

#### variables
if [ -z $my_portalname ]; then
    echo "ERROR: portalname is unset"
    exit $error_variables_missing
fi

if [ -z $my_projectid ]; then
    echo "ERROR: projectid is unset"
    exit $error_variables_missing
fi

if [ -z $my_cloudmesh_dir ]; then
    my_cloudmesh_dir=cloudmesh
    echo "WARNING: using default cloudmesh=$my_cloudmesh_dir"
fi

if [ ! -d $my_cloudmesh_dir ]; then
    echo "ERROR: could not find cloudmesh in $my_cloudmesh_dir"
    exit $error_missing_cm_repo
fi

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

############################################################ tracing and errors
set -o xtrace
set -o errexit

############################################################ all is good
#### fetch the appropriate files from futuresystems

cm-iu user fetch --username=$my_portalname
cm-iu user create

cd $my_cloudmesh_dir

# one-time generate the database
fab mongo.boot

# one-time populate db with user credentials and info
fab user.mongo:cloudmesh

# one-time refresh of cloud info
fab mongo.simple

# set the project id
cm project default $projectid
