provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "wordpress_igw"
  }
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = "wordpess-rt"
  }
}

resource "aws_route_table_association" "my_rt_association" {
  for_each       = var.subnets
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.my_rt.id
}

locals {
  subnet_to_associate = ["sub_1", "sub_2", "sub_3"]
}

resource "aws_subnet" "subnet" {
  for_each   = var.subnets
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.value

  tags = {
    name = each.key
  }
}
