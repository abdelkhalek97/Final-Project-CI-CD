resource "aws_instance" "ec2" {
  ami                         = "ami-06878d265978313ca"
  instance_type               = var.instType
  subnet_id                   = var.subnet_ids
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.secg_id]
  associate_public_ip_address = "true"
  iam_instance_profile        = aws_iam_instance_profile.instance_profile

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
sudo echo 'Host bastion
        hostname ${self.public_ip}
        user ubuntu
        port 22
        identityfile /home/abdelkhalek97/Desktop/Ansible-lab2/iti.pem' > /home/abdelkhalek97/.ssh/config
EOF
  }

  tags = {
    Name = "jump-host"
  }
}


resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2-instance-profile"

  role = var.instance_profile
}