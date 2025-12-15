locals {
  github_backup_write = "github-backup-write"
}

module "github_workflow_roles" {
  source            = "github.com/cds-snc/terraform-modules//gh_oidc_role?ref=v10.9.1"
  billing_tag_value = local.billing_tag_value
  roles = [
    {
      name      = local.github_backup_write
      repo_name = "*" # Allow any CDS repo to use this role
      claim     = "ref:refs/heads/main"
    }
  ]
}

#
# Allow GitHub workflows in CDS repos to write data to the backup bucket
#
resource "aws_iam_role_policy_attachment" "github_backup_write" {
  role       = local.github_backup_write
  policy_arn = aws_iam_policy.github_backup_write.arn
  depends_on = [
    module.github_workflow_roles
  ]
}

resource "aws_iam_policy" "github_backup_write" {
  name   = local.github_backup_write
  policy = data.aws_iam_policy_document.github_backup_write.json
}

data "aws_iam_policy_document" "github_backup_write" {
  statement {
    sid = "S3Write"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${module.backup_bucket.s3_bucket_arn}/*"
    ]
  }
}
