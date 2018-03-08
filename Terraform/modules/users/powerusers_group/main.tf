resource "aws_iam_group" "powerusers" {
  name = "powerusers"
}

#Gives PowerUser access to all services minus IAM and ORGANIZATIONS (IAM access is granted through ForceMFA policy)
data "aws_iam_policy_document" "powerusers" {
    statement = {
      effect = "Allow"
      not_actions = [
        "iam:*",
        "organizations:*"
      ]
      resources = [
        "*"
      ]
    }
}

resource "aws_iam_policy" "powerusers-policy" {
  name   = "powerusers"
  path   = "/"
  policy = "${data.aws_iam_policy_document.powerusers.json}"
}

resource "aws_iam_group_policy_attachment" "powerusers-attachment" {
  group      = "${aws_iam_group.powerusers.name}"
  policy_arn = "${aws_iam_policy.powerusers-policy.arn}"
}
