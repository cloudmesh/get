# Cloudmesh One Line Source Installers 


The install scripts are maintaned at

* <https://github.com/cloudmesh/get>

## Cloudmesh Version 4

To install cloudmesh version 4 you can use curl or wget into a python virtual envireonment.


With curl you can use the command 

    curl -L http://cloudmesh.github.io/get

to view the install script. If you like what you see you can install cloudmesh as follows
First, create a directory. Let us assume you call it `cm`. Lok into this directory.

    mkdir cm
    cd cm
    
Next download cloudmesh source directories and install them with pip. We recommend 
that you use pyenv or venv before you start the install.

    curl -L http://cloudmesh.github.io/get | sh 
    
You will find now all subdirectories in your install directory. All of them have been 
installed with pip in your python environment.    

