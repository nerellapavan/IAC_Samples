variable "employee_username" {}
variable "employee_email" {}
#variable "github_username" {}

variable "is_admin" {
  default = false
}

variable "is_poweruser" {
  default = true
}

variable "force_mfa" {
  default = false
}

variable "member_devops" {
  default = false
}
variable "member_developers" {
  default = false
}


