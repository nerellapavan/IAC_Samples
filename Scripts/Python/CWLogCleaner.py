import boto3
import json

prefix = raw_input('Enter the log name prefix you wish to search through: ')
#should verify that the user input something, if not then prompt or exit

#Connect to AWS using default AWS credentials in awscli config
cwlogs = boto3.client('logs')

loglist = cwlogs.describe_log_groups(
    logGroupNamePrefix=(prefix)
)

#writes json output to file...
with open('loglist.json', 'w') as outfile:
	json.dump(loglist, outfile, ensure_ascii=False, indent=4, sort_keys=True)

#Opens file and searches through to find given loggroup name
with open("loglist.json") as f:
 	file_parsed = json.load(f)

for i in file_parsed['logGroups']:
	print i['logGroupName']

#Decision point should be added here to prompt user to delete logs or not

#Deletes the log groups that begin with the given prefix
for i in file_parsed['logGroups']:
	cwlogs.delete_log_group(
   	    logGroupName=(i['logGroupName'])
	)


print('Done')
