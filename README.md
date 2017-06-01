# AWS_Infrastructure
Cloudformation - scripts for building AWS infrastructure
 - VPC -
 	East1-VPC.json - Contains Cloudformation templates that will build a VPC with a bastion (Ubuntu OS) in an ASG, 2 public and 2 private subnets. You could provision a 3rd EIP and have it auto assigned to the bastion server by adding the code in EIPAllocator.

Scripts - Various scripts and utilities
 - Python -
 	securitygroupinventory.py - Using boto it will run a describe on all security groups and output the data to a output.json file locally. It will also convert the json to a CSV file. The output to the CSV file needs to be cleaned up a bit.