data "aws_identitystore_group" "dev" {
  identity_store_id = local.identity_store_id

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Dev"
  }
}

resource "aws_ssoadmin_account_assignment" "dev_to_dev" {
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.dev.arn

  principal_id   = data.aws_identitystore_group.dev.group_id
  principal_type = "GROUP"

  target_id   = local.accounts.dev
  target_type = "AWS_ACCOUNT"
}

data "aws_identitystore_group" "admin" {
  identity_store_id = local.identity_store_id

  filter {
    attribute_path  = "DisplayName"
    attribute_value = "Admin"
  }
}

resource "aws_ssoadmin_account_assignment" "admin_to_dev" {
  instance_arn       = local.sso_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn

  principal_id   = data.aws_identitystore_group.admin.group_id
  principal_type = "GROUP"

  target_id   = local.accounts.dev
  target_type = "AWS_ACCOUNT"
}