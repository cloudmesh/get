VERSION=dev

VENV="$HOME/ENV"

# 3rd column is ubuntu/14.04 dependencies
deps=($(curl https://raw.githubusercontent.com/cloudmesh/get/$VERSION/cloudmesh/system-dependencies.csv | cut -d, -f3))

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
sudo apt-get -qq -y install ${deps[@]}

if test -d "$VENV"; then
    echo "WARNING: $VENV already exists, using it"
else
    virtualenv "$VENV"
fi
source "$VENV"/bin/activate

# due to circular dependencies, separate lines are needed
pip install cloudmesh_base
pip install cloudmesh

# need to install files into ~/.cloudmesh
cloudmesh_dir=cloudmesh.git
install_extra_args=
if test -d ~/.cloudmesh; then
    echo "WARNING ~/.cloudmesh directory already exists, overwriting files"
    install_extra_args='--force'
fi


test -d $cloudmesh_dir || git clone https://github.com/cloudmesh/cloudmesh.git $cloudmesh_dir
cd $cloudmesh_dir
git checkout dev2.0 # FIXME: remove on merge into master
git pull
./install new $install_extra_args

