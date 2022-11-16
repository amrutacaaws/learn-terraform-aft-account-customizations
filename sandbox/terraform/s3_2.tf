data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "sandbox_bucket_2" {
  bucket = "aft-sandbox-2-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
}