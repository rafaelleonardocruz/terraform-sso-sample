locals {
    accounts = {
        dev = element([for i in data.aws_organizations_organization.this.non_master_accounts : i.id if i.name == "dev-rafael"], 0)
    }
    identity_store_id = element(tolist(data.aws_ssoadmin_instances.this.identity_store_ids), 0)
    sso_instance_arn = element(tolist(data.aws_ssoadmin_instances.this.arns), 0)
}