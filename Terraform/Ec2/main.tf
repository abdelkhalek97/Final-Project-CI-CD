resource "aws_instance" "ec2" {
  ami                         = "ami-06878d265978313ca"
  instance_type               = var.instType
  subnet_id                   = var.subnet_ids
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.secg_id]
  associate_public_ip_address = "true"

  tags = {
    Name = "jump-host"
  }
}

