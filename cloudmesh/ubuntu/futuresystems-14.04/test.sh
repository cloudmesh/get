#!/usr/bin/env bash

set -o xtrace
set -o errexit

PROVISION_CMD="curl https://raw.githubusercontent.com/cloudmesh/get/master/cloudmesh/ubuntu/14.04.sh | bash"
IMAGE=futuresystems/ubuntu-14.04
FLAVOR=m1.medium

tmpname=$(mktemp -d get-cloudmesh-test-XXXXX)
pushd $tmpname

keyname=$tmpname-key
nova keypair-add $keyname >$keyname
chmod 600 $keyname

# these may already exist, so set +o errexit around them
set +e
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/22
nova secgroup-add-rule default tcp 22 22 0.0.0.0/22
set -e

net_id=$(nova net-list| awk '/ int-net / {print $2}')
nova boot \
    --flavor $FLAVOR \
    --image $IMAGE \
    --nic net-id=$net_id \
    --key_name $keyname \
    $tmpname

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

if [ -z $ipaddr ]; then
    echo "Timeout waiting for machine to start up"
    exit 1
fi

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

if [ -z $ok ]; then
    echo "Timeout waiting for ssh connection"
    exit 1
fi

ssh -i $keyname ubuntu@$ipaddr \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    "$PROVISION_CMD"

# cleanup
nova stop $tmpname
nova delete $tmpname
nova keypair-delete $keyname

popd
rm -rf $tmpname
