#!/usr/bin/env bash

set -e
set -x
set -o pipefail

apt-get update
apt-get -y install jq

# get environment variables from tags
INSTANCE_METADATA=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01")
TAGS=$(echo "${INSTANCE_METADATA}" | jq -r .compute.tags )
HOSTNAME=$(echo "${INSTANCE_METADATA}" | jq -r .compute.name)
HOST_IP=$(echo "${INSTANCE_METADATA}" | jq -r .network.interface[0].ipv4.ipAddress[0].privateIpAddress)
RESOURCE_GROUP=$(echo "${INSTANCE_METADATA}" | jq -r .compute.resourceGroupName)
IFS=';' read -r -a TAG_ARRAY <<<"${TAGS}"

export HOST_IP RESOURCE_GROUP

for tag in "${TAG_ARRAY[@]}"
do
  KEY=$(echo "${tag}" | awk -F: '{print $1}' | tr '[:lower:]' '[:upper:]')
  VALUE=$(echo "${tag}" | awk -F: '{print $2}')
  eval "${KEY}=${VALUE}"
done
