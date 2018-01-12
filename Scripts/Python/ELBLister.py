#Sill in progress

import boto3
from botocore.exceptions import ClientError
import json

#Connect to AWS using default AWS credentials in awscli config
connection = boto3.client('elb')

#Describes all of the ELBs in the EAST region and returns just the names
ELBlist = connection.describe_load_balancers()

for i in ELBlist['LoadBalancerDescriptions']:
	print i['LoadBalancerName']
