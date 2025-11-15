module "backup_bucket" {
  source            = "github.com/cds-snc/terraform-modules//S3?ref=v10.8.6"
  bucket_name       = local.bucket_name
  billing_tag_value = local.billing_tag_value

  lifecycle_rule = [
    local.lifecycle_expire_all
  ]

  versioning = {
    enabled = true
  }
}
