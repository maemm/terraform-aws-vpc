resource "aws_route" "default_route" {
  count                  = length(var.subnets_names)
  route_table_id         = element(aws_route_table.rtbl.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = element(var.public_ip, count.index) == true ? aws_internet_gateway.igw[0].id : ""
  nat_gateway_id         = element(var.public_ip, count.index) == false ? aws_nat_gateway.ngtw.id : ""
}

