
module "powerusers_group" {
  source = "./modules/users/powerusers_group"
}

module "forcemfa_group" {
  source = "./modules/users/forcemfa_group"
}

module "administrators_group" {
  source = "./modules/users/administrators_group"
}


# Declare users below

module "seth_floyd" {
  source = "./modules/users"
  employee_username = "seth.floyd"
  employee_email = "corp@address.com"
  #github_username = "sethfloydjr"
  is_admin = true
  member_devops = true
}

