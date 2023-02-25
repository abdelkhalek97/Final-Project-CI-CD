resource "aws_instance" "ec2" {
  ami                         = "ami-0557a15b87f6559cf"
  instance_type               = var.instType
  subnet_id                   = var.subnet_ids
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.secg_id]
  associate_public_ip_address = "true"
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.id

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
sudo echo 'Host bastion
        hostname ${self.public_ip}
        user ubuntu
        port 22
        identityfile /home/abdelkhalek97/Desktop/Final-project/Terraform/iti.pem
Host remote-host
  HostName ${var.priavte_ip}
  ProxyJump bastion
  user ec2-user
  port 22
  identityfile /home/abdelkhalek97/Desktop/Final-project/Terraform/iti.pem' > /home/abdelkhalek97/.ssh/config
EOF
  }
    connection {
    type        = var.connection_type
    user        = var.connection_user
    private_key = file(var.connection_private_key)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = var.file_source
    destination = var.file_destination
  }

    provisioner "remote-exec" {
    inline = var.inline
  }

    provisioner "file" {
    source      = "../K8s-Files/"
    destination = "/home/ubuntu/"
  }

  tags = {
    Name = "jump-host"
  }
}


resource "aws_iam_instance_profile" "instance_profile" {
  name = "ec2-instance-profile"

  role = var.instance_profile
}