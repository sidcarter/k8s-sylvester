# The Azure Template Way

This is the azure implementation of kubernetes the hard way, using azure resource manager templates

## What does it do?

The templates creates:

* a vnet
* a subnet
* a security group (associated with the subnet)
* a frontend load balancer (for the api server)

And then the following are launched too:

* number of controllers specified
* number of nodes specified

## What's remaining?

* create certs
* setup etcd
* setup controllers
* setup nodes
* bring the cluster up
* setup pop security policies
* setup dns
* run smoke tests
