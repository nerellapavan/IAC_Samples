#This script will pull a listing of AMI images that are owned by your account, with a certain prefix, older than a certain date...and DEREGISTER them.

#DESCRIBE
#http://boto3.readthedocs.io/en/latest/reference/services/ec2.html?highlight=deregister#EC2.Client.describe_images
#DEREGISTER
#http://boto3.readthedocs.io/en/latest/reference/services/ec2.html?highlight=deregister#EC2.Client.deregister_image

import boto3
import json


#DO NOT STORE YOUR CREDENTIALS IN THIS SCRIPT! IT IS INSECURE! SET ENVIRONMENT VARIABLES...SEE THIS PAGE IF YOU NEED HELP:
#http://boto3.readthedocs.io/en/latest/guide/configuration.html#credentials
#By default your DEFAULT user in your  ~/.aws/crednetials file is being used...KNOW WHO YOU ARE LOGGED IN AS SINCE THIS SCRIPT IS DESTRUCTIVE
ec2 = boto3.client(
	'ec2')

response = ec2.describe_images(
    Owners=[
        '119585928394',
    ],
    Filters=[
        {
            'Name': 'name',
            'Values': ['convox-host-*']
        },
    ]
	)

#writes json output to file...
with open('response.json', 'w') as outfile:
	json.dump(response, outfile, ensure_ascii=False, indent=4, sort_keys=True, separators=(',', ': '))


#Searches response.jon for entries that have a CreationDate older than TODAY-45 days.
#might help:  https://stackoverflow.com/questions/8383136/parsing-json-and-searching-through-it
#https://stackoverflow.com/questions/2835559/parsing-values-from-a-json-file
data = json.load(open('response.json'))
data_date= data ['Images'] [0] ['CreationDate']
print(data_date)


#prints this:   2017-12-24T11:05:32.000Z