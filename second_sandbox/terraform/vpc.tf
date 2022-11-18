data "aws_caller_identity" "current_vpc" {}

data "aws_ssm_parameter" "azs" {
  name = "/aft/account-request/custom-fields/azs"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name = "/aft/account-request/custom-fields/vpc_cidr"
}

data "aws_ssm_parameter" "vpc_private_subnets" {
  name = "/aft/account-request/custom-fields/vpc_private_subnets"
}


data "aws_ssm_parameter" "vpc_public_subnets" {
  name = "/aft/account-request/custom-fields/vpc_public_subnets"
}

resource "aws_vpc" "main_second_sandbox" {
  # cidr_block       = "10.0.0.0/16"
  cidr_block       = data.aws_ssm_parameter.vpc_cidr.value
  instance_tenancy = "default"

  tags = {
    Name = "${data.aws_caller_identity.current_vpc.account_id}"
  }
}


# resource "aws_subnet" "private_subnet_main_second_sandbox" {
#   # count = 3
#   # name  = "private_subnet_main_second_sandbox.${count.index}"

#   count = length(data.aws_ssm_parameter.vpc_private_subnets.value)
#   cidr_block = data.aws_ssm_parameter.vpc_private_subnets.value[count.index]
#   vpc_id     = aws_vpc.main_second_sandbox.id
#   # cidr_block = split(",", data.aws_ssm_parameter.vpc_private_subnets.value)


#   tags = {
#     Name = "private_subnet_main_second_sandbox"
#   }
# }



resource "aws_subnet" "private_subnet_main_second_sandbox" {
  # count                   = "${length(data.aws_ssm_parameter.vpc_private_subnets.value)}"
  vpc_id                  = "${aws_vpc.main_second_sandbox.id}"
  cidr_block              = "${data.aws_ssm_parameter.vpc_private_subnets.value}"
  # availability_zone       = "${data.data.aws_ssm_parameter.azs.value}"
  map_public_ip_on_launch = false
}