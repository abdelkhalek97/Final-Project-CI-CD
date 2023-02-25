output "vpc_id" {
  value = aws_vpc.main.id

}

output "pup_subnet_id" {
  value = tolist(values(aws_subnet.subnets_public)[*].id)

}

output "priv_subnet_id" {
  value = tolist(values(aws_subnet.subnets_private)[*].id)

}