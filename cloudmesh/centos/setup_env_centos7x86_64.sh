#!/usr/bin/env bash

#####################################################################################################
# The script installs the prerequisites and bootstraps a fresh centOS instance to install cloudmesh #
# This script is meant to be run on a fresh centOS machine and may not be necessarily idempotent.   #
#####################################################################################################

echo "### Installing prereq packages ###"
sudo yum install -y gcc wget zlib-devel openssl-devel sqlite-devel bzip2-devel

echo "### Downloading Python 2.7.10 ###"
cd $HOME
if [ ! -e Python-2.7.10.tgz ]; then
    wget --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
fi

echo "### Downloading Python supplemental scripts ###"
if [ ! -e ez_setup.py ]; then
    wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
fi

if [ ! -e get-pip.py ]; then
    wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
fi

echo "### Installing Python 2.7.10 and configuring it ###"
tar -xvzf Python-2.7.10.tgz
cd Python-2.7.10
./configure --prefix=/usr/local
sudo make && sudo make altinstall
export PATH="/usr/local/bin:$PATH"

echo "### Checking Python version ###"

/usr/local/bin/python2.7 --version

echo "### Installing setuptools ###"
cd $HOME
sudo /usr/local/bin/python2.7 ez_setup.py

echo "### Installing pip ###"
sudo /usr/local/bin/python2.7 get-pip.py

echo "### Creating Symlinks ###"
sudo ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
sudo ln -sf /usr/local/bin/pip /usr/bin/pip

echo "### Ugrading pip if not latest ###"
pip install -U pip

echo "### Checking pip version ###"
pip --version

echo "### Installing virtualenv ###"
sudo pip install virtualenv

echo "### Configuring and activating virtualenv ###"
virtualenv -p /usr/local/bin/python $HOME/ENV
source $HOME/ENV/bin/activate

if ! [[ $(grep "ENV/bin/activate" $HOME/.bashrc) ]] > /dev/null; then
    echo "source $HOME/ENV/bin/activate" >> $HOME/.bashrc
fi

echo "Cloning the cloudmesh code repositories"
cd $HOME
mkdir cloudmesh
cd cloudmesh
git clone https://github.com/cloudmesh/base.git
git clone https://github.com/cloudmesh/client.git

pip install -r base/requirements.txt
pip install -r base/requirements-other.txt

pip install -r client/requirements.txt
pip install -r client/requirements-doc.txt

cd $HOME/base
python setup.py install

cd $HOME/client
python setup.py install

cd $HOME

echo "### Congratulations! Cloudmesh successfully installed and ready to use. ###"
