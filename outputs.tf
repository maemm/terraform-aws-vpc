output "subnets_id" {
  value       = aws_subnet.subnets.*.id
  description = "List of the subnet's id"
}

output "vpc_id" {
  value       = aws_vpc.custom_vpc.*.id
  description = "Custom VPC id"
}

output "vpc_default_id" {
  value       = aws_default_vpc.default-vpc.id
  description = "Default VPC id"
}

output "nacl_ids" {
  value       = aws_network_acl.nacls.*.id
  description = "List of the NACL's id"
}

output "rtbl_ids" {
  value       = aws_route_table.rtbl.*.id
  description = "List of the Route table's id"
}

