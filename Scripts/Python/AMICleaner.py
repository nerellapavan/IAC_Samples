#This script will pull a listing of AMI images that are owned by your account, with a certain prefix, older than a certain date...and DEREGISTER them.

#DESCRIBE
#http://boto3.readthedocs.io/en/latest/reference/services/ec2.html?highlight=deregister#EC2.Client.describe_images
#DEREGISTER
#http://boto3.readthedocs.io/en/latest/reference/services/ec2.html?highlight=deregister#EC2.Client.deregister_image

import boto3
import json


#By default your DEFAULT user in your ~/.aws/crednetials file is being used...KNOW WHO YOU ARE LOGGED IN AS SINCE THIS SCRIPT IS DESTRUCTIVE
ec2 = boto3.client(
	'ec2')

response = ec2.describe_images(
    Owners=[
        '119585928394', #Your account number goes here
    ],
    Filters=[
        {
            'Name': 'name',
            'Values': ['convox-host-*'] #Prefix of AMIs you are looking for goes here
        },
    ]
	)

#Searches response.json for entries that have a CreationDate older than TODAY-45 days...
#writes json output to file...
with open('response.json', 'w') as outfile:
	json.dump(response, outfile, ensure_ascii=False, indent=4, sort_keys=True, separators=(',', ': '))

#Searches file...
with open("response.json") as f:
 	file_parsed = json.load(f)

#Prints out a list of CreationDates...
for date in file_parsed['Images']:
	print date['CreationDate']

#Now deregister the ones that are older than TODAY minus 45 days...
