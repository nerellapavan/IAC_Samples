resource "aws_iam_group" "forcemfa" {
  name = "forcemfa"
}

resource "aws_iam_policy" "forcemfa-policy" {
  name   = "forcemfa"
  path   = "/"
  policy = "${data.aws_iam_policy_document.forcemfa.json}"
}

resource "aws_iam_group_policy_attachment" "forcemfa-attachment" {
  group      = "${aws_iam_group.forcemfa.name}"
  policy_arn = "${aws_iam_policy.forcemfa-policy.arn}"
}

#Forces MFA on users in group this policy is attached to
data "aws_iam_policy_document" "forcemfa" {
    statement {
        sid = "AllowAllUsersToListAccounts"
        actions = [
                  "iam:ListAccountAliases",
                  "iam:ListUsers",
                  "iam:GetAccountSummary"
        ]
        effect = "Allow"
        resources = [
                  "*"
        ]
    }
    statement {
        sid = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation",
        effect = "Allow"
        actions = [
                "iam:ChangePassword",
                "iam:CreateAccessKey",
                "iam:CreateLoginProfile",
                "iam:DeleteAccessKey",
                "iam:DeleteLoginProfile",
                "iam:GetAccountPasswordPolicy",
                "iam:GetLoginProfile",
                "iam:ListAccessKeys",
                "iam:UpdateAccessKey",
                "iam:UpdateLoginProfile",
                "iam:ListSigningCertificates",
                "iam:DeleteSigningCertificate",
                "iam:UpdateSigningCertificate",
                "iam:UploadSigningCertificate",
                "iam:ListSSHPublicKeys",
                "iam:GetSSHPublicKey",
                "iam:DeleteSSHPublicKey",
                "iam:UpdateSSHPublicKey",
                "iam:UploadSSHPublicKey"
        ]
        resources = [
                "arn:aws:iam::$${var.aws_account_id}:user/$${aws:username}"
        ]
    }
    statement {
        sid = "AllowIndividualUserToListOnlyTheirOwnMFA",
        effect = "Allow",
        actions = [
                "iam:ListVirtualMFADevices",
                "iam:ListMFADevices"
        ]
        resources = [
                "arn:aws:iam::$${var.aws_account_id}:mfa/*",
                "arn:aws:iam::$${var.aws_account_id}:user/$${aws:username}"
        ]
    }
    statement {
        sid = "AllowIndividualUserToManageTheirOwnMFA",
        effect = "Allow",
        actions = [
                "iam:CreateVirtualMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:RequestSmsMfaRegistration",
                "iam:FinalizeSmsMfaRegistration",
                "iam:EnableMFADevice",
                "iam:ResyncMFADevice"
        ]
        resources = [
                "arn:aws:iam::$${var.aws_account_id}:mfa/$${aws:username}",
                "arn:aws:iam::$${var.aws_account_id}:user/$${aws:username}"
        ]
    }
    statement {
        sid = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA",
        effect = "Allow",
        actions = [
                "iam:DeactivateMFADevice"
        ]
        resources = [
                "arn:aws:iam::$${var.aws_account_id}:mfa/$${aws:username}",
                "arn:aws:iam::$${var.aws_account_id}:user/$${aws:username}"
        ]
        condition {
                test = "Bool"
                variable = "aws:MultiFactorAuthPresent"
                values = [
                "true"
                ]
        }
    }
    statement {
        sid = "BlockAnyAccessOtherThanAboveUnlessSignedInWithMFA",
        effect = "Deny",
        not_actions = [
              "iam:*",
        ]
        resources = [
                "*"
        ]
        condition {
                test = "Bool"
                variable = "aws:MultiFactorAuthPresent"
                values = [
                "false"
                ]
        }
    }
}
