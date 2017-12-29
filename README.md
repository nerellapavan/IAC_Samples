# AWS_Infrastructure
## Cloudformation - scripts for building AWS infrastructure
### VPC -

**East1-VPC.json** - Contains Cloudformation templates that will build a VPC with a bastion (Ubuntu OS) in an ASG, 2 public and 2 private subnets. You could provision a 3rd EIP and have it auto assigned to the bastion server by adding the code in EIPAllocator.

## Docker - Various Docker and ECS images and scripts/functions
### Docker -
**Dockerfile** - Use this to create an image that will install Packer. By adding a few lines for where the image should pick up the files you can dump your packer.json file into this image and then add a script to kick off the packer run automatically once the image is started. A breif example is in the code. The dockerfile itself can be run with the following command: `docker build -t demo-packer:demo-packer --rm=true .`


## Scripts - Various scripts and utilities
### Python -

**CWLogCleaner.py** - Using boto this script will delete cloudwatch logs based on the "prefix" that you input. This is a useful script when you have multiple log groups that all start with the same few letters such as "company-name-" where the full log group name might be "company-name-loggroup-number001", "company-name-loggroup-number002", "company-name-loggroup-number003", and so on into the hundreds.

**ELBLister.py** - Describes all of the ELBs in the EAST region and returns just the names. More could be added to this to actually do something with those names.

**MFAChecker.py** - Not useful at this time but the plan is to scan for users who are and are not using MFA on their users since AWS doesnt provide a way to enforce this important security rule outside of a policy file.

**SGInventory.py** - Using boto it will run a describe on all security groups and output the data to a output.json file locally. It will also convert the json to a CSV file. The output to the CSV file needs to be cleaned up a bit.


## Terraform - Various Terraform scripts and utilities

**state.tf** - Modify the bucket name and key(path) in this file to match your own in AWS S3. Place the "terraform.tfstate" file in the location described by 'key' in the state.tf file.


## Packer - Various Packer build templates
**Packer.json** - A packer file that will spin up an AMI based on Ubuntu 16.04, install OS updates, install chefdk 1.4.3, clones down a sample Berksfile, adds some slight config for berks and then will install whatever you have in the berksfile. In this case its just nginx.
The command for this file is:
`packer build -var 'aws_access_key=YOUR_ACCESS_KEY' -var 'aws_secret_key=YOUR_SECRET_KEY' -var 'vpc_id=YOUR_VPC_ID' -var 'subnet_id=YOUR_SUBNET_ID' packer.json` You need to tell packer your VPC and Subnet IDs because it cant figure out what your default ids are or which vpc you want this AMI in.
