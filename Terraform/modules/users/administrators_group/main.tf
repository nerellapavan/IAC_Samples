resource "aws_iam_group" "group" {
  name = "administrators"
}

data "aws_iam_policy_document" "policy" {
    statement = {
      effect = "Allow"
      actions = [
        "*"
      ]
      resources = [
        "*"
      ]
    }
}

resource "aws_iam_policy" "policy" {
  name   = "administrators"
  path   = "/"
  policy = "${data.aws_iam_policy_document.policy.json}"
}

resource "aws_iam_group_policy_attachment" "attachment" {
  group      = "${aws_iam_group.group.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
