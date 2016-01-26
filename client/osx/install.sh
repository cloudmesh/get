#! /bin/sh

sudo easy_install pip
sudo pip install virtualenv
virtualenv -p /user/local/bin/python ~/ENV
source ~/ENV/bin/activate
export PYTHONPATH=~/ENV/lib/python2.7/site-packages:$PYTHONPATH
pip install pip -U
easy_install readline
easy_install pycrypto
pip install urllib3
