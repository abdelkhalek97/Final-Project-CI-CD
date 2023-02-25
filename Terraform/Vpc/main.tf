resource "aws_vpc" "main" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = var.vpc-name
  }
}


data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "subnets_public" {
  for_each = { for idx, subnet in keys(var.subnet_cidrs_public) :
    idx => {
      name = subnet
      cidr = var.subnet_cidrs_public[subnet]
    }
  }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = element(data.aws_availability_zones.available.names, each.key)
  map_public_ip_on_launch = true
  tags = {
    Name = "public ${each.key}"
    "kubernetes.io/cluster/demo" = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "subnets_private" {
  for_each = { for idx, subnet in keys(var.subnet_cidrs_private) :
    idx => {
      name = subnet
      cidr = var.subnet_cidrs_private[subnet]
    }
  }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = element(data.aws_availability_zones.available.names, each.key)

  tags = {
    Name = "private ${each.key}"
    "kubernetes.io/cluster/demo" = "owned"
    "kubernetes.io/role/internal-elb" = 1
  }
}