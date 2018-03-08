resource "aws_iam_user" "iam_user" {
  name          = "${var.employee_username}"
  path          = "/"
  force_destroy = true
}

#module "user-datadog" {
#  source ="./datadog"
#  corp-email = "${var.employee_email}"
#  ddname = "${var.employee_username}"
#  isddadmin = "false"
#}

#module "user-github" {
#  source ="./github"
#  ghusername = "${var.github_username}"
#  member_devops = "${var.member_devops}"
#  member_developers = "${var.member_developers}"
#}

resource "aws_iam_group_membership" "forcemfa" {
  count = "${var.force_mfa}"

  name = "forcemfa-membership"
  users = [
    "${aws_iam_user.iam_user.name}"
  ]
  group = "forcemfa"
}

resource "aws_iam_group_membership" "powerusers" {
  count = "${var.is_poweruser}"

  name = "powerusers-membership"
  users = [
    "${aws_iam_user.iam_user.name}"
  ]
  group = "powerusers"
}

resource "aws_iam_group_membership" "administrators" {
  count = "${var.is_admin}"

  name = "administrators-membership"
  users = [
    "${aws_iam_user.iam_user.name}"
  ]
  group = "administrators"
}
