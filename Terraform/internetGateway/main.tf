resource "aws_internet_gateway" "internetgatway" {
  vpc_id = var.vpcid

  tags = {
    Name = var.internetgatewayName
  }
}