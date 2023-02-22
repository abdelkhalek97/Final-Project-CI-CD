resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instType
  count                       = length(var.subnet_ids)
  subnet_id                   = var.subnet_ids[count.index]
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.secg_id]
  associate_public_ip_address = "true"

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

  provisioner "local-exec" {
    command = "echo Public-ip ${count.index}: ${self.public_ip} >> ./all-ips.txt"
  }

  tags = {
    Name = "${var.name} ${count.index + 1}"
  }
}




resource "aws_instance" "ec2_priv" {
  ami                    = var.ami_id_priv
  instance_type          = var.instType_priv
  count                  = length(var.subnet_ids_priv)
  subnet_id              = var.subnet_ids_priv[count.index]
  vpc_security_group_ids = [var.secg_id_priv]
  key_name               = var.key_name_priv
  user_data              = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
    sudo chmod 777 /var/www/html
    sudo chmod 777 /var/www/html/index.nginx-debian.html
    sudo echo '<h1>Hi from private Instance ${count.index + 1} </h1>' > /var/www/html/index.nginx-debian.html
    sudo systemctl restart nginx
  EOF


  provisioner "local-exec" {
    command = "echo Private-ip ${count.index}: ${self.private_ip} >> ./all-ips.txt"
  }
  tags = {
    Name = "${var.name_priv} ${count.index + 1}"
  }
}


