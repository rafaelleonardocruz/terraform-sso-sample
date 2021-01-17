data "aws_identitystore_group" "dev" {
  identity_store_id = element(tolist(data.aws_ssoadmin_instances.this.identity_store_ids), 0)

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Dev"
  }
}

resource "aws_ssoadmin_account_assignment" "dev_to_dev" {
  instance_arn       = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  permission_set_arn = aws_ssoadmin_permission_set.dev.arn

  principal_id   = data.aws_identitystore_group.dev.group_id
  principal_type = "GROUP"

  target_id   = element([for i in data.aws_organizations_organization.this.non_master_accounts : i.id if i.name == "dev-rafael"], 0)
  target_type = "AWS_ACCOUNT"
}

data "aws_identitystore_group" "admin" {
  identity_store_id = element(tolist(data.aws_ssoadmin_instances.this.identity_store_ids), 0)

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Admin"
  }
}

resource "aws_ssoadmin_account_assignment" "admin_to_dev" {
  instance_arn       = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn

  principal_id   = data.aws_identitystore_group.admin.group_id
  principal_type = "GROUP"

  target_id   = element([for i in data.aws_organizations_organization.this.non_master_accounts : i.id if i.name == "dev-rafael"], 0)
  target_type = "AWS_ACCOUNT"
}