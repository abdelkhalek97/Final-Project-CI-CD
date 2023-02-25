resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "lab-nat-gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = var.publicSubnetId

  tags = {
    Name = "Lab - NAT"
  }

  # To ensure proper ordering, add Internet Gateway as dependency
  depends_on = [var.dependency]
}
