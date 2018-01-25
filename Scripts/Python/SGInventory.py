#Still in progress
#This script will Pull an inventory of all security groups and list the open ports/ip addresses

import boto3
from botocore.exceptions import ClientError
import json

#Connect to AWS using default AWS credentials in awscli config
ec2 = boto3.client('ec2')

#AWSCLI command that describes security groups
response = ec2.describe_security_groups()

#writes json output to file...
#print(response)

with open('SGOutput.json', 'w') as outfile:
	json.dump(response, outfile, ensure_ascii=False, indent=4, sort_keys=True)



##################################################

#write output to CSV file locally
#import csv
import csv

with open("SGOutput.json") as f:
 file_parsed = json.load(f)

file_data = file_parsed['SecurityGroups']

#open a file for writing
data = open('SGOutput.csv', 'w')

#create the csv writer object

csvwriter = csv.writer(data)

count = 0

for entry in  file_data:
	if count ==0:
		header = entry.keys()
		csvwriter.writerow(header)
		count += 1
	csvwriter.writerow(entry.values())
f.close()
