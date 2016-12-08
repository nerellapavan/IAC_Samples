# AWS_Infrastructure
Cloudformation scripts for building AWS infrastructure


East1-VPC.json - Sets up a VPC with 2 public subnets both with NAT Gateways, 2 private subnets, and a bastion host (Ubuntu OS) in a auto scaling group. You could provision a 3rd EIP and have it auto assigned to the bastion server by adding the code in EIPAllocator.

