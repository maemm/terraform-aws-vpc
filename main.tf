resource "aws_vpc" "custom_vpc" {
  count      = var.custom_vpc ? 1 : 0
  cidr_block = var.vpc_cidr

  tags = {
    Name      = "${var.env_name}-Custom-VPC"
    terraform = "true"
  }
}

resource "aws_default_vpc" "default-vpc" {
}

resource "aws_internet_gateway" "igw" {
  count  = var.custom_vpc ? 1 : 0
  vpc_id = aws_vpc.custom_vpc[0].id

  tags = {
    Name      = "${var.env_name}-custom-vpc-igw"
    terraform = "true"
  }
}

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name      = "${var.env_name}-ngtw-eip"
    terraform = "true"
  }
}

resource "aws_nat_gateway" "ngtw" {
  allocation_id = aws_eip.eip.id
  subnet_id = element(
    aws_subnet.subnets.*.id,
    index(var.subnets_names, var.nat_gw_subnet) * length(var.az_list),
  )

  tags = {
    Name      = "${var.env_name}-ngtw"
    terraform = "true"
  }
}

