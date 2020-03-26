#!/usr/bin/env bash

#####################################################################################################
# The script installs the prerequisites and bootstraps a fresh centOS instance to install cloudmesh #
# This script is meant to be run on a fresh centOS machine and may not be necessarily idempotent.   #
#####################################################################################################

pybaseversion="2.7"
pyextversion="10"

echo "### Installing prereq packages ###"
sudo yum install -y git gcc wget zlib-devel openssl-devel sqlite-devel bzip2-devel

if [ $? -ne 0 ]; then
    echo "ERROR: Error installing prerequisite packages."
    exit 1
fi

echo "### Downloading Python $pybaseversion.$pyextversion ###"
cd $HOME
if [ ! -e Python-$pybaseversion.$pyextversion.tgz ]; then
    wget --no-check-certificate https://www.python.org/ftp/python/$pybaseversion.$pyextversion/Python-$pybaseversion.$pyextversion.tgz

    if [ $? -ne 0 ]; then
        echo "ERROR: Cloud not download Python $pybaseversion.$pyextversion."
        exit 1
    fi
fi

echo "### Downloading Python supplemental scripts ###"
if [ ! -e ez_setup.py ]; then
    wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py

    if [ $? -ne 0 ]; then
        echo "ERROR: Cloud not download ez_setup.py."
        exit 1
    fi
fi


if [ ! -e get-pip.py ]; then
    wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py

    if [ $? -ne 0 ]; then
        echo "ERROR: Cloud not download get-pip.py."
        exit 1
    fi
fi

echo "### Installing Python $pybaseversion.$pyextversion and configuring it ###"
tar -xvzf Python-$pybaseversion.$pyextversion.tgz

if [ $? -ne 0 ]; then
    echo "ERROR: Could not extract python archive."
    exit 1
fi

cd Python-$pybaseversion.$pyextversion
./configure --prefix=/usr/local
sudo make && sudo make altinstall

if [ $? -ne 0 ]; then
    echo "ERROR: Error installing python $pybaseversion.$pyextversion."
    exit 1
fi

export PATH="/usr/local/bin:$PATH"

echo "### Checking Python version ###"

/usr/local/bin/python$pybaseversion --version

echo "### Installing setuptools ###"
cd $HOME
sudo /usr/local/bin/python$pybaseversion ez_setup.py

if [ $? -ne 0 ]; then
    echo "ERROR: Error while executing ez_setup.py."
    exit 1
fi

echo "### Installing pip ###"
sudo /usr/local/bin/python$pybaseversion get-pip.py

if [ $? -ne 0 ]; then
    echo "ERROR: Error while executing get-pip.py."
    exit 1
fi

echo "### Creating Symlinks ###"
sudo ln -sf /usr/local/bin/python$pybaseversion /usr/local/bin/python
sudo ln -sf /usr/local/bin/pip /usr/bin/pip

if [ $? -ne 0 ]; then
    echo "ERROR: Error while creating symlinks."
    exit 1
fi

echo "### Ugrading pip if not latest ###"
pip install -U pip

if [ $? -ne 0 ]; then
    echo "ERROR: Error upgrading pip."
    exit 1
fi

echo "### Checking pip version ###"
pip --version

echo "### Installing virtualenv ###"
sudo pip install virtualenv

if [ $? -ne 0 ]; then
    echo "ERROR: Error while installing virtualenv."
    exit 1
fi

echo "### Configuring and activating virtualenv ###"
virtualenv -p /usr/local/bin/python $HOME/ENV

if [ $? -ne 0 ]; then
    echo "ERROR: Error while configuring virtualenv."
    exit 1
fi

source $HOME/ENV/bin/activate

if ! [[ $(grep "ENV/bin/activate" $HOME/.bashrc) ]] > /dev/null; then
    echo "source $HOME/ENV/bin/activate" >> $HOME/.bashrc

    if [ $? -ne 0 ]; then
        echo "ERROR: Error adding activate command to bashrc."
        exit 1
    fi
fi

echo "Cloning the cloudmesh code repositories"
cd $HOME

if [ ! -d cloudmesh ]; then
    mkdir cloudmesh
fi

cd cloudmesh

if [ ! -d base ]; then
    git clone https://github.com/cloudmesh/base.git
fi

if [ $? -ne 0 ]; then
    echo "ERROR: Error cloning cloudmesh base."
    exit 1
fi

if [ ! -d client ]; then
    git clone https://github.com/cloudmesh/client.git
fi

if [ $? -ne 0 ]; then
    echo "ERROR: Error cloning cloudmesh client."
    exit 1
fi

pip install -r base/requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh base requirements."
    exit 1
fi
pip install -r base/requirements-other.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh base other requirements."
    exit 1
fi

pip install -r client/requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh client requirements."
    exit 1
fi
pip install -r client/requirements-doc.txt

if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh client doc requirements."
    # Ignoring the doc install error as it does not block the cloudmesh installation and function.
    # exit 1
fi

cd $HOME/cloudmesh/base
python setup.py install
if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh base."
    exit 1
fi

cd $HOME/cloudmesh/client
python setup.py install
if [ $? -ne 0 ]; then
    echo "ERROR: Error installing cloudmesh client."
    exit 1
fi

cd $HOME

echo "### Congratulations! Cloudmesh successfully installed and ready to use. ###"
