VENV="$HOME/ENV"


deps=($(curl https://raw.githubusercontent.com/cloudmesh/get/master/cloudmesh/system-dependencies.csv | cut -d, -f3))

if [[ ! ${deps[0]} == "ubuntu/14.04" ]]; then
    # FIXME: bug report email address
    echo "An unexpected error occurred."
    echo "Please submit a bug"
fi

set -o pipefail
set -o errexit
set -o xtrace

deps=${deps[@]:1}

sudo apt-get update
sudo apt-get -y install ${deps[@]}

if [[ test -d "$VENV" ]]; then
    echo "WARNING: $VENV already exists, using it"
else
    virtualenv ~/ENV
fi
source "$VENV"/bin/activate

# due to circular dependencies, separate lines are needed
pip install cloudmesh_base
pip install cloudmesh
