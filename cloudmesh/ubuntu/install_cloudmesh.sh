#!/bin/bash

###########################################################################################################
# The script installs the prerequisites and bootstraps a fresh Ubuntu 14/15 instance to install cloudmesh #
# This script is meant to be run on a fresh Ubuntu 14/15 machine and may not be necessarily idempotent.   #
###########################################################################################################

pybaseversion="2.7"
pyextversion="10"

function check_error_exit {
    if [ $? -ne 0 ]; then
        echo "ERROR: Error updating system packages."
        exit 1
    fi
}

echo "### Updating system packages ###"
sudo apt-get update -y
check_error_exit "ERROR: Error updating system packages."

echo "### Upgrading system packages ###"
sudo apt-get upgrade -y
check_error_exit "ERROR: Error upgrading system packages."

echo "### Upgrading distribution packages ###"
sudo apt-get dist-upgrade -y
check_error_exit "ERROR: Error upgrading distribution packages."

echo "### Installing necessary prerequisite packages ###"
sudo apt-get install python-setuptools python-pip python-dev libncurses-dev git -y
check_error_exit "ERROR: Error installing prerequisites."

echo "### Installing readline & pycrypto ###"
sudo easy_install readline
sudo pip install pycrypto
check_error_exit "ERROR: Error installing readline & pycrypto."

echo "### Installing necessary dev & build tools packages ###"
sudo apt-get install build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev -y
check_error_exit "ERROR: Error installing dev & build tools."

echo "### Upgrading to Python $pybaseversion.$pyextversion ###"
cd $HOME
sudo apt-get install -y gcc-multilib g++-multilib libffi-dev libffi6 libffi6-dbg python-crypto python-mox3 python-pil python-ply libssl-dev zlib1g-dev libbz2-dev libexpat1-dev libbluetooth-dev libgdbm-dev dpkg-dev quilt autotools-dev libreadline-dev libtinfo-dev libncursesw5-dev tk-dev blt-dev libssl-dev zlib1g-dev libbz2-dev libexpat1-dev libbluetooth-dev libsqlite3-dev libgpm2 mime-support netbase net-tools bzip2
check_error_exit "ERROR: Error installing prerequisite packages for installing Python $pybaseversion.$pyextversion."

echo "### Downloading Python $pybaseversion.$pyextversion ###"
if [ ! -e Python-$pybaseversion.$pyextversion.tgz ]; then
	wget --no-check-certificate https://www.python.org/ftp/python/$pybaseversion.$pyextversion/Python-$pybaseversion.$pyextversion.tgz
	check_error_exit "ERROR: Cloud not download Python $pybaseversion.$pyextversion."
fi

echo "### Downloading Python supplemental scripts ###"
if [ ! -e ez_setup.py ]; then
	wget --no-check-certificate https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
	check_error_exit "ERROR: Cloud not download Python supplemental scripts."
fi

echo "### Installing Python $pybaseversion.$pyextversion and configuring it ###"
tar -xvzf Python-$pybaseversion.$pyextversion.tgz
check_error_exit "ERROR: Could not extract python archive."

cd Python-$pybaseversion.$pyextversion
./configure --prefix /usr/local/lib/python2.7.10 --enable-ipv6
check_error_exit "ERROR: Error configuring Python-$pybaseversion.$pyextversion."

make
sudo make install
check_error_exit "ERROR: Error installing Python-$pybaseversion.$pyextversion."

echo "### Checking Python version ###"
/usr/local/lib/python$pybaseversion.$pyextversion/bin/python --version

echo "### Installing ez_setup ###"
sudo /usr/local/lib/python$pybaseversion.$pyextversion/bin/python ez_setup.py
#check_error_exit "ERROR: Error installing ez_setup."

echo "### Installing pip and virtualenv ###"
#sudo /usr/local/lib/python$pybaseversion.$pyextversion/bin/easy_install pip
sudo /usr/local/lib/python$pybaseversion.$pyextversion/bin/pip install virtualenv
sudo apt-get install python-virtualenv
check_error_exit "ERROR: Error installing virtualenv."

echo "### Creating symbolic links ###"
sudo ln -sf /usr/local/lib/python$pybaseversion.$pyextversion/bin/easy_install /usr/bin/easy_install
sudo ln -sf /usr/local/lib/python$pybaseversion.$pyextversion/bin/pip /usr/bin/pip

echo "### Checking pip version ###"
pip --version

echo "### Creating and activating python virtualenv ###"
virtualenv -p /usr/local/lib/python$pybaseversion.$pyextversion/bin/python $HOME/ENV
source $HOME/ENV/bin/activate

if [ $? -ne 0 ]; then
	echo "ERROR: Error creating symbolic links"
	exit 1
else
	echo "Python virtualenv successfully created in ".$HOME."/ENV directory."
fi

echo "### Updating pip in python virtualenv ###"
pip install pip -U
check_error_exit "ERROR: Error updating pip"

echo "### Checking pip & python version ###"
pip --version
python --version

if ! [[ $(grep "ENV/bin/activate" $HOME/.bashrc) ]] > /dev/null; then
	echo "source $HOME/ENV/bin/activate" >> $HOME/.bashrc
    check_error_exit "ERROR: Error adding activate command to bashrc."
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

check_error_exit "ERROR: Error cloning base repository"

if [ ! -d client ]; then
	git clone https://github.com/cloudmesh/client.git
fi

check_error_exit "ERROR: Error cloning client repository"

echo "Installing cloudmesh base requirements"
pip install -r base/requirements.txt

check_error_exit "ERROR: Error installing cloudmesh base requirements."

pip install -r base/requirements-other.txt
check_error_exit "ERROR: Error installing cloudmesh base other requirements."

echo "Installing cloudmesh client requirements"
pip install -r client/requirements.txt
check_error_exit "ERROR: Error installing cloudmesh client requirements."

pip install -r client/requirements-doc.txt
if [ $? -ne 0 ]; then
	echo "ERROR: Error installing cloudmesh client doc requirements."
	# Ignoring the doc install error as it does not block the cloudmesh installation and function.
	#exit 1
fi

echo "Installing cloudmesh BASE"
cd $HOME/cloudmesh/base
python setup.py install
check_error_exit "ERROR: Error installing cloudmesh BASE."

echo "Installing cloudmesh CLIENT"
cd $HOME/cloudmesh/client
python setup.py install
check_error_exit "ERROR: Error installing cloudmesh CLIENT."

cd $HOME
echo "### Congratulations! Cloudmesh successfully installed and ready to use. Run 'cm' to open the cloudmesh shell ###"