#!/bin/bash

#From here you could use a script that might pull the AWS credentials from either a file within a S3 bucket,
#or a service like CircleCI or Jenkins that can hold your credentials as a secure environment variable.

#Something similar to:
#AWS_KEY=$AWS_ACCESS_KEY
#AWS_SECRET=$AWS_SECRET_KEY
#Then pass these through a simple bash script to the packer build command like:
#$ packer build \
#    -var 'aws_access_key=$AWS_KEY' \
#    -var 'aws_secret_key=$AWS_SECRET' \
#    packer.json