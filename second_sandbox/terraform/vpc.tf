data "aws_caller_identity" "current_vpc" {}

resource "aws_vpc" "main_second_sandbox" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${data.aws_caller_identity.current_vpc.account_id}"
  }
}