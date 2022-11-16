data "aws_caller_identity" "current_s3" {}

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = "aft-sandbox-${data.aws_caller_identity.current_s3.account_id}"
  acl    = "private"
}
