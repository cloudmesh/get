# Cloudmesh One Line Source Installers 

> ---------------------------
> Update: For a possibly easier approach see also 
>
> * <https://github.com/cloudmesh/cloudmesh-installer/blob/master/README.md>
> * <https://github.com/cloudmesh/cloudmesh-installer/blob/master/FAQ.md>
>
> ---------------------------

We are providing at 

* <https://github.com/cloudmesh/cloudmesh-install/blob/master/README.md>

A a simple script manager for those that need to work on the cloudmesh source code.
Please visit that page for more information. You can install the installer with 

```bash
$ pip install cloudmesh-installer
```
> .

First we recomend to uninstall all old versions. you can find them with 

\
```bash
find ~ -name "cloudmesh*"
find / -name "cloudmesh*"
```
find all egs, wheels and links to them and delete them. Be careful so you do not delete your source


Instead of reading on her, pleas go to 


> * <https://github.com/cloudmesh/cloudmesh-installer/blob/master/README.md>
> * <https://github.com/cloudmesh/cloudmesh-installer/blob/master/FAQ.md>















THE FOLLOWING IS OUTDATED:


The install scripts are maintaned at

* <https://github.com/cloudmesh/get>

## Uninstall old cloudmesh verisons

in case you installed cloudmesh with pip in your python you can uninstall it with:

    curl -Ls http://cloudmesh.github.io/get/uninstall?$(date +%s) | sh

Naturally if you have other python programs that depend on the old versions that
you developed you should uninstall them also. In case you have use -e on pip, in
cloudmesh related directories, simple visit them and say

    make clean

If it does not have a make file or make does not work on your system, simple
remov the `*egg` directory and remove all __pycache__ directories.

To find additional old versions you can also use commands such as find.

```bash
cd ~; find . -name "cloudmesh*egg*"
cd /; find . -name "cloudmesh*egg*"
```

please delete them all. Certainly you can also start with a ne VM if you used one. 

## Uninstall the pyenv

The easiest way to uninstall is if you used a pyenv or venv. In case of pyenv,
you simple do the following commands. Let us assume you follwoed the inatltion
of a pyenv of the name ENV3 as discussed in our handbook.

    rm ~/.pyenv/shims/cms
    pyenv deactivate
    pyenv uninstall ENV3
    pyenv virtualenv 3.7.3 ENV3
    pyenv activate ENV3
    pip install pip -U

This will install a new completely empty environment

## Install Cloudmesh Source Version 4

To install cloudmesh version 4 you can use curl or wget into a python virtual
environment.

    mkdir cm
    cd cm
    curl -Ls http://cloudmesh.github.io/get?$(date +%s) | sh 
    
You will find now all subdirectories in your install directory. All of them have been 
installed with pip in your python environment.    

## Update Cloudmesh Source Version 4

Once you have installed the source code in the directory, you can update via a
git pull for the core packages (common, cmd5, sys, openapi, bar, but also nn) it
with (you must be in the same directory where you executed the get command in)

    curl -Ls http://cloudmesh.github.io/get/pull?$(date +%s) | sh
    
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
You are running a supported version of python: 3.7.3
You are running a supported version of pip: 19.0.3
```

Naturally you can also specify the format and output the information in json so its easier to paste and copy

    cms version --format=json

Bug: In some cases we found that the table does not show. Please help us debug
it. The doce is in cloudmesh-cmd.



# Code devlopment for cloud and storage

After you have successfully done the previous step (if the previous step does
not succeed do not continue and work with us to figure out what could be wrong),
you need to install in case you work on 

* vm providers install 

  ```bash
  cd cloudmesh-cloud 
  pip install -e .
  ```
  
* storage providers

  ```bash
  cd cloudmesh-cloud 
  pip install -e . 
  cd .. 
  cd cloudmesh-storage 
  pip install -e .
#

You must do this after a pull.

## Alternative Install with local shell script

This is an alternative way to install cloudmesh

```bash
mkdir cm
cd cm
git clone git@github.com:cloudmesh/get.git
get/bin/get
```

Than when you need to update

```bash
get/bin/pull
```

You will still need to pull and pip install the 

```
cloudmesh-cloud
cloudmesh-storage
```

directories! so make sure they are up to date






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
