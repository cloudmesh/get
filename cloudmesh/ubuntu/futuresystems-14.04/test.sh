#!/usr/bin/env bash

set -o xtrace  # trace output
set -o errexit # exit if a command fails

PROVISION_CMD="curl https://raw.githubusercontent.com/cloudmesh/get/master/cloudmesh/ubuntu/14.04.sh | bash"
IMAGE=futuresystems/ubuntu-14.04
FLAVOR=m1.medium

### name this test
tmpname=$(mktemp -d get-cloudmesh-test-XXXXX)
pushd $tmpname

# key-pair add
keyname=$tmpname-key
nova keypair-add $keyname >$keyname
chmod 600 $keyname

### add security group rules
# these may already exist, so set +o errexit around them
set +e
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/22
nova secgroup-add-rule default tcp 22 22 0.0.0.0/22
set -e

### Boot the machine
net_id=$(nova net-list| awk '/ int-net / {print $2}')
nova boot \
    --flavor $FLAVOR \
    --image $IMAGE \
    --nic net-id=$net_id \
    --key_name $keyname \
    $tmpname

# need to wait until the machine is active with an assigned IP before continuing
nova list
echo "Waiting until an IP is assigned"
for i in $(seq 10); do
    state=$(nova list | grep $tmpname | awk '{print $6}')
    if [ "$state" == "ACTIVE" ]; then
	break
    else
	sleep 5s
    fi
done
nova list

ipaddr=$(nova list | grep $tmpname | egrep -o 'int-net=([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)' | cut -d= -f2)

# sanity check
if [ -z $ipaddr ]; then
    echo "Timeout waiting for machine to start up"
    exit 1
fi

# need to wait until sshd is running
# use netcat to check if a process is listening on port 22 for sshd
echo "Waiting until ssh is running"
for i in $(seq 10); do
    if nc -zv $ipaddr 22; then
	ok="Y"
	break
    else
	ok=
	sleep 10s
    fi
done

# sanity check
if [ -z $ok ]; then
    echo "Timeout waiting for ssh connection"
    exit 1
fi


### log in and provision
ssh -i $keyname ubuntu@$ipaddr \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    "$PROVISION_CMD"

### cleanup
nova stop $tmpname
nova delete $tmpname
nova keypair-delete $keyname

popd
rm -rf $tmpname
