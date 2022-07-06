resource "aws_subnet" "subnets" {
  count                   = length(var.subnets_names) * length(var.az_list)
  cidr_block              = element(var.subnets_cidr, count.index)
  vpc_id                  = var.custom_vpc == true ? aws_vpc.custom_vpc[0].id : aws_default_vpc.default-vpc.id
  map_public_ip_on_launch = element(var.public_ip, floor(count.index / length(var.az_list)))
  availability_zone       = element(var.az_list, count.index % length(var.az_list))

  tags = {
    Name = format(
      "%[1]s-%[2]d",
      element(var.subnets_names, floor(count.index / length(var.az_list))),
      count.index % length(var.az_list) + 1,
    )
    terraform = "true"
  }
}

resource "aws_network_acl" "nacls" {
  count  = length(var.subnets_names)
  vpc_id = var.custom_vpc == true ? aws_vpc.custom_vpc[0].id : aws_default_vpc.default-vpc.id
  subnet_ids = slice(
    aws_subnet.subnets.*.id,
    count.index * length(var.az_list),
    count.index * length(var.az_list) + length(var.az_list),
  )

  tags = {
    Name      = element(var.subnets_names, count.index)
    terraform = "true"
  }
}

resource "aws_route_table" "rtbl" {
  count  = length(var.subnets_names)
  vpc_id = var.custom_vpc == true ? aws_vpc.custom_vpc[0].id : aws_default_vpc.default-vpc.id

  tags = {
    Name      = element(var.subnets_names, count.index)
    terraform = "true"
  }
}

resource "aws_route_table_association" "rtbl-association" {
  count          = length(var.subnets_names) * length(var.az_list)
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = element(aws_route_table.rtbl.*.id, floor(count.index / length(var.az_list)))
}

