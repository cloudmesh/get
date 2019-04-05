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

## Uninstall the pyenv

The easiest way to uninstall is if you used a pyenv or venv. In case of pyenv,
you simple do the following commands. Let us assume you follwoed the inatltion
of a pyenv of the name ENV3 as discussed in our handbook.

    rm ~/.pyenv/shims/cms
    pyenv deactivate
    peyenv uninstall ENV3
    pyenv install 3.7.2 ENV3
    pyenv activate ENV3

This will install a new completely empty environment

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

    curl -Ls http://cloudmesh.github.io/get/pull | sh
    
  Please note that other packages you have to update by hand


## Checking the Module Versions

Once you successfully installed cloudmesh version 4 you can check the versions
and path of the modules with

    cms version

In case you see a module that you do not like go to the directory and uninstall
it there dependent on how you installed it, either with pipi uninstall or
removing the pycach and egg files in the directory. The output will look something like  this:

```
+--------------------+--------------------+---------+------------------------------------------+
| name               | package            | version | source                                   |
+--------------------+--------------------+---------+------------------------------------------+
| cloudmesh-cloud    | cloudmesh.cloud    | 4.0.17  | /Users/aida/.pyenv/versions/3.7.2/envs/E |
|                    |                    |         | NV3/lib/python3.7/site-                  |
|                    |                    |         | packages/cloudmesh/cloud/__init__.py     |
| cloudmesh-cmd5     | cloudmesh.cmd5     | 4.0.12  | /Users/aida/.pyenv/versions/3.7.2/envs/E |
|                    |                    |         | NV3/lib/python3.7/site-                  |
|                    |                    |         | packages/cloudmesh/cmd5/__init__.py      |
| cloudmesh-common   | cloudmesh.common   | 4.0.13  | /Users/aida/.pyenv/versions/3.7.2/envs/E |
|                    |                    |         | NV3/lib/python3.7/site-packages/cloudmes |
|                    |                    |         | h_common-4.0.13-py3.7.egg/cloudmesh/comm |
|                    |                    |         | on/__init__.py                           |
| cloudmesh-sys      | cloudmesh.sys      | 4.0.12  | /Users/aida/.pyenv/versions/3.7.2/envs/E |
|                    |                    |         | NV3/lib/python3.7/site-                  |
|                    |                    |         | packages/cloudmesh/sys/__init__.py       |
| git hash           |                    |         |                                          |
| pip                |                    | 19.0.3  |                                          |
| python             |                    | 3.7.2   |                                          |
+--------------------+--------------------+---------+------------------------------------------+
You are running a supported version of python: 3.7.2
You are running a supported version of pip: 19.0.3
```

Bug: In some cases we found that the table does not show. Please help us debug
it. The doce is in cloudmesh-cmd.

## Repositories


### CORE

* https://github.com/cloudmesh/cloudmesh-common
* https://github.com/cloudmesh/cloudmesh-cmd5
* https://github.com/cloudmesh/cloudmesh-sys
* https://github.com/cloudmesh/cloudmesh-cloud
* https://github.com/cloudmesh/cloudmesh-storage
* https://github.com/cloudmesh/cloudmesh-emr

### OPEN API

* https://github.com/cloudmesh/cloudmesh-openapi
* https://github.com/cloudmesh/cloudmesh-nn
* https://github.com/cloudmesh/cloudmesh-nist

### EXPERIMENTAL

* https://github.com/cloudmesh/cloudmesh-inventory
* https://github.com/cloudmesh/cloudmesh-conda

### MANAGEMENT ABD WEB PAGE

* https://github.com/cloudmesh/get
* https://github.com/cloudmesh/about
* https://github.com/cloudmesh/cloudmesh.github.io
* https://github.com/cloudmesh-community/cloudmesh-community.github.io
