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
#SESSION_TOKEN = os.getenv('AWS_SESSION_TOKEN')

print('Connecting...')
ec2 = boto3.client(
    'ec2',
    aws_access_key_id=ACCESS_KEY,
    aws_secret_access_key=SECRET_KEY
#Needed if you enforce MFA for the user running this
#   aws_session_token=SESSION_TOKEN
)

def checkIfOlder(isoformat, targetDate):
    dateAsString = datetime.datetime.strptime(isoformat, '%Y-%m-%dT%H:%M:%S.%fZ')
    return dateAsString <= targetDate

#CertainDate X days ago
certainDate = datetime.now() - timedelta(days=45)
print(certainDate)


print('Describing AMIs...')
response = ec2.describe_images(
    Owners=[
        'self', #Your account number can also go here...otherwise owner is the sender of the request if using 'self'
        ],
    Filters=[
        {
            'Name': 'name',
            'Values': ['host-name-*'], #Change this to match your AMIs...Prefix of AMIs you are looking for goes here
            'Name': 'is-public',
            'Values': ['false'] #Looks for only private images in your account
        },
    ]
    )

#writes json output to file...
print('Writing to response.json...')
with open('response.json', 'w') as outfile:
    json.dump(response, outfile, ensure_ascii=False, indent=4, sort_keys=True, separators=(',', ': '))


print('Opening response.json...')
with open("response.json") as f:
    file_parsed = json.load(f)


#Find AMIS older than X days...

for ami in file_parsed['Images']:
    creationDate = ami['CreationDate']
    if checkIfOlder(creationDate, certainDate):
        print('This AMI will be deleted...')
        print(ami['ImageId'])
#The below is the danger part. Leave commented out unless you want to deregister your images older than the date you set for certainDate
#        for ami in file_parsed['Images']:
#            ec2.deregister_image(
#            ImageId=(ami['ImageId'])
#            )