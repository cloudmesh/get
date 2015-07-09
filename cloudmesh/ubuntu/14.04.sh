#!/usr/bin/env bash

# freeze versions due to issue https://github.com/cloudmesh/get/issues/11
CMD3_VERSION=1.8.1
CLOUDMESH_BASE_VERSION=2.5.15
CLOUDMESH_VERSION=2.3.1
CLOUDMESH_COMMIT=0022179a3eab180642482bd8001293e0a1d04576

my_cloudmeshdir=$cloudmeshdir
test -z $my_cloudmeshdir && my_cloudmeshdir="cloudmesh"

VERSION=master # master branch is stable

VENV="$venv"

if [ -z $VENV ]; then
    VENV="$HOME/ENV"
    echo "\$venv is not provided: setting to $VENV"
fi

# 1st column is ubuntu/14.04 dependencies
deps=($(curl -s https://raw.githubusercontent.com/cloudmesh/get/$VERSION/cloudmesh/system-dependencies.csv | cut -d, -f1))

if [[ ! ${deps[0]} == "ubuntu/14.04" ]]; then
    # FIXME: bug report email address
    echo "An unexpected error occurred."
    echo "Please submit a bug"
    exit 1
fi

set -o errexit
set -o xtrace

deps=${deps[@]:1}

sudo apt-get -qq update
# see issue 10
# https://github.com/cloudmesh/get/issues/10
bash <<+END
sudo apt-get -y install ${deps[@]}
exit $?
+END

if test -d "$VENV"; then
    echo "WARNING: $VENV already exists, using it"
else
    virtualenv "$VENV"
fi
source "$VENV"/bin/activate

# remove the InsecurePlatformWarning messages (issue #12)
pip install --upgrade requests[security]

# upgrade pip to handle some dependency issues
pip install --upgrade pip

pip install cloudmesh_base==$CLOUDMESH_BASE_VERSION
pip install cmd3==$CMD3_VERSION
pip install cloudmesh==$CLOUDMESH_VERSION

# need to install files into ~/.cloudmesh
install_extra_args=
if test -d ~/.cloudmesh; then
    echo "WARNING ~/.cloudmesh directory already exists, overwriting files"
    install_extra_args='--force'
fi


test -d $my_cloudmeshdir || git clone https://github.com/cloudmesh/cloudmesh.git $my_cloudmeshdir
cd $my_cloudmeshdir
git pull
git checkout $CLOUDMESH_COMMIT
./install new $install_extra_args

