locals {
  billing_tag_value = "SRE"
  bucket_name       = "cds-snc-github-backups"

  lifecycle_expire_all = {
    id      = "Expire backups"
    enabled = true
    expiration = {
      days = "60"
    }
  }
}