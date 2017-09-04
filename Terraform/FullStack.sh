#!/bin/bash

echo "Enter the AWS Access key:"
read aws_access_key

echo "Enter your AWS Secret key:"
read aws_secret_key

echo "Enter your VPC ID:"
read vpc_id

echo "Enter your subnet id:"
read subnet_id

packer build -var 'aws_access_key=${aws_access_key}' \
-var 'aws_secret_key=${aws_secret_key}' \
#-var 'vpc_id=${vpc_id}' \
#-var 'subnet_id=${subnet_id}' \
packer.json 2>&1 | sudo tee output.txt

tail -2 output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > ami.txt

amiid=$(cat ami.txt)

echo "variable \"region\" { default = \"us-east-1\"} ami_id = \"$amiid\"" >> ami_id.tf

terraform init

terraform plan -var ami_id=$amiid

#terraform apply

rm -rf ami.txt
rm -rf ami_id.tf
