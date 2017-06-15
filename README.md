# AWS_Infrastructure
## Cloudformation - scripts for building AWS infrastructure
### VPC -

**East1-VPC.json** - Contains Cloudformation templates that will build a VPC with a bastion (Ubuntu OS) in an ASG, 2 public and 2 private subnets. You could provision a 3rd EIP and have it auto assigned to the bastion server by adding the code in EIPAllocator.

## Scripts - Various scripts and utilities
### Python -

**CWLogCleaner.py** - Using boto this script will delete cloudwatch logs based on the "prefix" that you input into the code. This may be made to be more interactive in the future. For now look in the code to see where to enter your cloudwatch log group prefix name. This is a useful script when you have multiple loggroups that all start with the same few letters such as "company-name-" where the full og group name might be "company-name-loggroup-number001", "company-name-loggroup-number002", "company-name-loggroup-number003", and so on.

**ELBLister.py** - Describes all of the ELBs in the EAST region and returns just the names. More could be added to this to actually do something with those names.

**MFAChecker.py** - Not useful at this time but the plan is to scan for users who are and are not using MFA on their users since AWS doesnt provide a way to enforce this important security rule.

**SGInventory.py** - Using boto it will run a describe on all security groups and output the data to a output.json file locally. It will also convert the json to a CSV file. The output to the CSV file needs to be cleaned up a bit.
