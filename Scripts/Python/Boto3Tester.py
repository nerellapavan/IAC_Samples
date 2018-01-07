import boto3

#Simple script to make sure you have botot installed correctly and it works as expected
#Keep in mind that this follows what permissions your IAM user has so if you cant do 'aws s3 ls' because of Access Denied then this wont work either

#This will use the credentials in your ~/.aws/crdentials file found in your [personal] profile...
#change to match your profile name or to 'default' for default profile.
session = boto3.session.Session(profile_name='personal')
s3 = session.resource('s3')

# Print out bucket names
for bucket in s3.buckets.all():
    print(bucket.name)