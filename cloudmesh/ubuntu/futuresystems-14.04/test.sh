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
sleep 5s
nova list

ipaddr=$(nova list | grep $tmpname | egrep -o 'int-net=([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)' | cut -d= -f2)

echo "Waiting until ssh is running"
sleep 30s
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
