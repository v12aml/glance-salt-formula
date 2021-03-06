#!/bin/bash

set -e

source /root/openrc

IMAGE_ID=$(glance image-list 2>/dev/null | awk '/cirros/{print $2}')
IMAGE_NAME="cirros"
if [ "x$IMAGE_ID" != "x" ]; then
    echo
    echo "changed=no comment='Image cirros in already exist'"
else
    wget -c -q http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img -O /tmp/cirros-0.3.4-x86_64-disk.img
    glance image-create --name $IMAGE_NAME --file /tmp/cirros-0.3.4-x86_64-disk.img \
        --disk-format qcow2 --container-format bare --visibility public
    echo
    echo "changed=yes comment='Image cirros has been created'"
fi
