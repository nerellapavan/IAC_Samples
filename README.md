# AWS_Infrastructure
## Cloudformation - scripts for building AWS infrastructure
### VPC -

**East1-VPC.json** - Contains Cloudformation templates that will build a VPC with a bastion (Ubuntu OS) in an ASG, 2 public and 2 private subnets. You could provision a 3rd EIP and have it auto assigned to the bastion server by adding the code in EIPAllocator.

## Docker - Various Docker and ECS images and scripts/functions
### Docker -

### ECS -


## Scripts - Various scripts and utilities
### Python -

**CWLogCleaner.py** - Using boto this script will delete cloudwatch logs based on the "prefix" that you input. This is a useful script when you have multiple log groups that all start with the same few letters such as "company-name-" where the full log group name might be "company-name-loggroup-number001", "company-name-loggroup-number002", "company-name-loggroup-number003", and so on into the hundreds.

**ELBLister.py** - Describes all of the ELBs in the EAST region and returns just the names. More could be added to this to actually do something with those names.

**MFAChecker.py** - Not useful at this time but the plan is to scan for users who are and are not using MFA on their users since AWS doesnt provide a way to enforce this important security rule.

**SGInventory.py** - Using boto it will run a describe on all security groups and output the data to a output.json file locally. It will also convert the json to a CSV file. The output to the CSV file needs to be cleaned up a bit.


## Terraform - Various Terraform and Packer scripts and utilities

**Packer.json** - A packer file that will spin up an AMI based on Ubuntu 16.04, install OS updates, install chefdk 1.4.3, clones down a sample Berksfile, adds some slight config for berks and then will install whatever you have in the berksfile. In this case its just nginx.
The command for this file is:
`packer build -var 'aws_access_key=YOUR_ACCESS_KEY' -var 'aws_secret_key=YOUR_SECRET_KEY' -var 'vpc_id=YOUR_VPC_ID' -var 'subnet_id=YOUR_SUBNET_ID' packer.json` You need to tell packer your VPC and Subnet IDs because it cant figure out what your default ids are or which vpc you want this AMI in.
