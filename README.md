# Cloudmesh One Line Source Installers 


The install scripts are maintaned at

* <https://github.com/cloudmesh/get>

## Uninstall old cloudmesh verisons

in case you installed cloudmesh with pip in your python you can uninstall it with:

    curl -Ls http://cloudmesh.github.io/get/uninstall | sh

Naturally if you have other python programs that depend on the old versions that
you developed you should uninstall them also. In case you have use -e on pip, in
cloudmesh related directories, simple visit them and say

    make clean

If it doe not have a make file or make does not work on your system, simple
remov the `*egg` directory and remove all __pycache__ directories.


## Install Cloudmesh Source Version 4

To install cloudmesh version 4 you can use curl or wget into a python virtual
envireonment.


With curl you can use the command 

    curl -Ls http://cloudmesh.github.io/get

to view the install script. If you like what you see you can install cloudmesh
as follows First, create a directory. Let us assume you call it `cm`. Look into
this directory.

    mkdir cm
    cd cm
    
Next download cloudmesh source directories and install them with pip. We recommend 
that you use pyenv or venv before you start the install.

    curl -Ls http://cloudmesh.github.io/get | sh 
    
You will find now all subdirectories in your install directory. All of them have been 
installed with pip in your python environment.    

## Update Cloudmesh Source Version 4

Once you have installed the source code in the directory, you can update via a
git pull for the core packages (common, cmd5, sys, openapi, bar, but also nn) it
with

    curl -Ls http://cloudmesh.github.io/get/pull
    
  Please note that other packages you have to update by hand

## Repositories


### CORE

* https://github.com/cloudmesh/cloudmesh-common
* https://github.com/cloudmesh/cloudmesh-cmd5
* https://github.com/cloudmesh/cloudmesh-sys
* https://github.com/cloudmesh-community/cloudmesh-cm4
* https://github.com/cloudmesh-community/cloudmesh-storage
* https://github.com/cloudmesh-community/cloudmesh-emr

### OPEN API

* https://github.com/cloudmesh/cloudmesh-openapi
* https://github.com/cloudmesh/cloudmesh-nn
* https://github.com/cloudmesh-community/nist

### EXPERIMENTAL

* https://github.com/cloudmesh/cloudmesh-inventory

### MANAGEMENT ABD WEB PAGE

* https://github.com/cloudmesh/get
* https://github.com/cloudmesh/about
* https://github.com/cloudmesh/cloudmesh.github.io
* https://github.com/cloudmesh-community/cloudmesh-community.github.io
