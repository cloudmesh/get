# Cloudmesh One Line Source Installers 


The install scripts are maintaned at

* <https://github.com/cloudmesh/get>

## Cloudmesh Version 4

To install cloudmesh version 4 you can use curl or wget into a python virtual envireonment.


With curl you can use the command 

    curl -L http://cloudmesh.github.io/get

to view the install script. If you like what you see you can install cloudmesh as follows
First, create a directory. Let us assume you call it `cm`. Look into this directory.

    mkdir cm
    cd cm
    
Next download cloudmesh source directories and install them with pip. We recommend 
that you use pyenv or venv before you start the install.

    curl -L http://cloudmesh.github.io/get | sh 
    
You will find now all subdirectories in your install directory. All of them have been 
installed with pip in your python environment.    

## Directories


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

* git clone https://github.com/cloudmesh/cloudmesh-inventory

### MANAGEMENT ABD WEB PAGE

* https://github.com/cloudmesh/get
* https://github.com/cloudmesh/about
* https://github.com/cloudmesh/cloudmesh.github.io
* https://github.com/cloudmesh-community/cloudmesh-community.github.io
