data "aws_caller_identity" "current_vpc" {}

data "aws_ssm_parameter" "azs" {
  name = "/aft/account-request/custom-fields/azs"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/path/to/vpc_cidr"
}

data "aws_ssm_parameter" "vpc_private_subnets" {
  name = "/path/to/vpc_private_subnets"
}


data "aws_ssm_parameter" "vpc_public_subnets" {
  name = "/path/to/vpc_public_subnets"
}

resource "aws_vpc" "main_second_sandbox" {
  # cidr_block       = "10.0.0.0/16"
  cidr_block       = data.aws_ssm_parameter.ami.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${data.aws_caller_identity.current_vpc.account_id}"
  }
}

