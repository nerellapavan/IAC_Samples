#Still in progress
#This script will cull a list of IAM users and check to see if they have MFA enabled or not and produce a report

import boto3

# Create IAM client
iam = boto3.client('iam')

# List users with the pagination interface
paginator = iam.get_paginator('list_users')
for response in paginator.paginate():
    print(response)
