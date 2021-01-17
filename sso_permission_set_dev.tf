resource "aws_ssoadmin_permission_set" "dev" {
  name             = "dev"
  description      = "Example permission set used by developers"
  instance_arn     = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  session_duration = "PT2H"

  tags = {
    Name      = "dev"
    Sso       = "true"
    Terraform = "true"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "dev_readonlyaccess" {
  instance_arn       = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.dev.arn
}

data "aws_iam_policy_document" "dev" {
  statement {
    sid = "AllowSsmPutObject"

    actions = [
      "ssm:PutObject",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "dev" {
  inline_policy      = data.aws_iam_policy_document.dev.json
  instance_arn       = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  permission_set_arn = aws_ssoadmin_permission_set.dev.arn
}