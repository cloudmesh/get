#! /bin/sh

sudo apt-get update
sudo apt-get upgrade 
sudo apt-get dist-upgrade
sudo apt-get install python-setuptools
sudo apt-get install python-pip
sudo apt-get install python-dev
sudo apt-get install libncurses-dev
sudo apt-get install git
sudo easy_install readline
sudo pip install pycrypto
sudo apt-get install build-essential checkinstall
sudo apt-get install libreadline-gplv2-dev
sudo apt-get install libncursesw5-dev
sudo apt-get install libssl-dev
sudo apt-get install libsqlite3-dev
sudo apt-get install tk-dev
sudo apt-get install libgdbm-dev
sudo apt-get install libc6-dev
sudo apt-get install libbz2-dev
cd $HOME
wget --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
tar xzf Python-2.7.10.tgz
cd Python-2.7.10
./configure --prefix=/usr/local
sudo make && sudo make altinstall
export PATH="/usr/local/bin:$PATH"
cd $HOME
sudo /usr/local/bin/python2.7 ez_setup.py
sudo /usr/local/bin/python2.7 get-pip.py
sudo ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
sudo ln -sf /usr/local/bin/pip /usr/bin/pip
pip install -U pip
virtualenv -p /usr/local/bin/python $HOME/ENV
