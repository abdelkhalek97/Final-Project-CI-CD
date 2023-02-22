resource "aws_route_table" "private_rt" {
  vpc_id = var.vpcid

  route {
    cidr_block     = var.pup-cidr
    nat_gateway_id = var.natGatewayName
    gateway_id     = var.internetGatewayName
  }

  tags = {
    Name = var.tableName
  }
}

resource "aws_route_table_association" "subnet_asso_priv" {
  count          = length(var.subnet_ids)
  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt.id
}


# resource "aws_route_table" "public_rt" {
#   vpc_id = var.vpcid

#   route {
#     cidr_block = var.pup-cidr
#     gateway_id = var.internetGatewayName
#   }

#   tags = {
#     Name = var.tableName
#   }
# }


# resource "aws_route_table_association" "subnet_asso" {
#   count          = length(var.subnet_ids)
#   subnet_id      = var.subnet_ids[count.index]
#   route_table_id = aws_route_table.public_rt.id
# }