#!/bin/sh
CLIENT_NAME="NAME-jb"
NUMBER_CLUSTERS=$1

for i in $(seq 1 $NUMBER_CLUSTERS); 
do
    export NAME="$CLIENT_NAME-$i.jb.io"
    echo "the name is $NAME"
    export KOPS_STATE_STORE="s3://jb-cloud-terraform-vpc-remote-state"
    export ZONES="eu-west-1a"
    export NETWORK_CIDR=10.60.0.0/16
    cd $CLIENT_NAME/clusters/cluster-$i/
    #terraform destroy -force
    kops delete cluster --name=$CLIENT_NAME-$i.jb.io --yes
    echo "Dir on exit"
    cd ../../../
    pwd
    
done
