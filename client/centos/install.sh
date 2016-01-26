#! /bin/sh

sudo yum install -y gcc wget zlib-devel openssl-devel sqlite-devel bzip2-devel
 cd $HOME
 wget --no-check-certificate https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
 wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
 wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
 tar -xvzf Python-2.7.10.tgz
 cd Python-2.7.10
 ./configure --prefix=/usr/local
 sudo make && sudo make altinstall
 export PATH="/usr/local/bin:$PATH"
 cd $HOME
 sudo /usr/local/bin/python2.7 ez_setup.py
 sudo /usr/local/bin/python2.7 get-pip.py
 sudo ln -s /usr/local/bin/python2.7 /usr/local/bin/python
 sudo ln -s /usr/local/bin/pip /usr/bin/pip
 pip install -U pip
 sudo pip install virtualenv
 virtualenv -p /usr/local/bin/python $HOME/ENV

 
