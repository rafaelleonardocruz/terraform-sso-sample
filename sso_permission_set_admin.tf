resource "aws_ssoadmin_permission_set" "admin" {
  name             = "admin"
  description      = "Example permission set used by Administrators"
  instance_arn     = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  session_duration = "PT2H"

  tags = {
    Name      = "admin"
    Sso       = "true"
    Terraform = "true"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "admin_administratoraccess" {
  instance_arn       = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
}
