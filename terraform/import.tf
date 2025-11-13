import {
  to = module.backup_bucket.aws_s3_bucket.this
  identity = {
    bucket = local.bucket_name
  }
}

import {
  to = module.backup_bucket.aws_s3_bucket_public_access_block.this
  id = local.bucket_name
}
