#!/usr/bin/env python
# -*- coding: utf-8 -*-

import boto3
import json
import time
from time import strftime
from datetime import datetime
from datetime import timedelta
import os
import subprocess

ACCESS_KEY = os.getenv('AWS_ACCESS_KEY_ID')
SECRET_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
REGION = os.getenv('AWS_REGION')

print('Connecting...')
ec2 = boto3.client(
    'ec2',
    aws_access_key_id=ACCESS_KEY,
    aws_secret_access_key=SECRET_KEY,
    region_name=REGION
)

def checkIfOlder(isoformat, targetDate):
    dateAsString = datetime.strptime(isoformat, '%Y-%m-%dT%H:%M:%S.%fZ')
    return dateAsString <= targetDate

#CertainDate X days ago
certainDate = datetime.utcnow() - timedelta(days=45) #Set your number of days in the past here
print(certainDate)

response = ec2.describe_images(
    Owners=[
        'self', #Your account number can also go here...otherwise owner is the sender of the request if using 'self'
        ],
    Filters=[
        {
            'Name': 'name',
            'Values': ['PREFIX_OF_YOUR_AMIS'], #Change this to match your AMIs...Prefix of AMIs you are looking for goes here
            'Name': 'is-public',
            'Values': ['false'] #Looks for only private images in your account
        },
    ]
    )

#writes json output to file to look at later...Can be shipped to S3 or somewhere else.
with open('response.json', 'w') as outfile:
    json.dump(response, outfile, ensure_ascii=False, indent=4, sort_keys=True, separators=(',', ': '))

with open("response.json") as f:
    file_parsed = json.load(f)

#Find AMIS older than X days (certainDate)...
for ami in file_parsed['Images']:
    creationDate = ami['CreationDate']
    if checkIfOlder(creationDate, certainDate):
        image_id = ami['ImageId']
        print("'This AMI will be deleted: {}".format(image_id))
        # Below is the danger part. Leave commented out unless you want to deregister your images older than the date you set for certainDate
        """
        ec2.deregister_image(
            ImageId=image_id
        )
        """