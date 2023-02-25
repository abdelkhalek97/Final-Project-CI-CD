module "vpc" {
  source               = "./Vpc"
  vpc-cidr             = "10.0.0.0/16"
  vpc-name             = "terraform"
  subnet_cidrs_public  = { public1 : "10.0.0.0/24", public2 : "10.0.1.0/24" }
  subnet_cidrs_private = { private1 : "10.0.2.0/24", private2 : "10.0.3.0/24" }

}
module "internetgateway1" {
  source              = "./internetGateway"
  internetgatewayName = "Terraform internetgateway"
  vpcid               = module.vpc.vpc_id

}

module "natG" {
  source         = "./natGateway"
  dependency     = module.internetgateway1.ig-id
  publicSubnetId = module.vpc.pup_subnet_id[0]

}

module "routing_public" {
  source              = "./routeTable"
  vpcid               = module.vpc.vpc_id
  internetGatewayName = module.internetgateway1.ig-id
  tableName           = "public Route Table"
  subnet_ids          = module.vpc.pup_subnet_id
}

module "routing_private" {
  source         = "./routeTable"
  vpcid          = module.vpc.vpc_id
  natGatewayName = module.natG.nat_id
  tableName      = "private Route Table"
  subnet_ids     = module.vpc.priv_subnet_id
}

module "securityGroup" {
  source               = "./SecurityGroup"
  vpcid                = module.vpc.vpc_id
  pup-cidr             = "0.0.0.0/0"
  sg_name              = "security_group"
  sg_description       = "security_group"
  sg_from_port_ingress = 80
  sg_to_port_ingress   = 80
  sg_protocol_ingress  = "tcp"
  sg_from_port_egress  = 0
  sg_to_port_egress    = 0
  sg_protocol_egress   = "-1"
}

module "eks" {
  source     = "./eks"
  subnet_ids = module.vpc.priv_subnet_id
  sg = module.securityGroup.sg_id

}

module "node" {
  source      = "./eks-node"
  subnet_ids  = module.vpc.priv_subnet_id
  clusterDemo = module.eks.clusterDemo
}

module "bastion-host" {
  source           = "./Ec2"
  instType         = "t2.micro"
  subnet_ids       = module.vpc.pup_subnet_id[1]
  secg_id          = module.securityGroup.sg_id
  name             = "proxy"
  key_name         = "iti"
  file_source = "./configures.sh"
  file_destination       = "/tmp/configures.sh"
  instance_profile = module.node.iam_id
  priavte_ip = module.node.node-ip
  connection_type        = "ssh"
  connection_user        = "ubuntu"
  connection_private_key = "./iti.pem"
  inline = ["chmod 777 /tmp/configures.sh", "/tmp/configures.sh"]
  depends_on = [
    module.node
  ]
}