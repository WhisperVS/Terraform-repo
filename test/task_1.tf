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
  for_each       = toset(var.subnets_to_associate)
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_subnet" "subnet" {
  for_each   = var.subnets
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.value

  tags = {
    name = each.key
  }
}

resource "aws_security_group" "my_sg" {
  name        = "wordpress-sg"
  description = "Security group for WordPress"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "wordpress-sg"
  }

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"
  public_key = var.public_key
}

resource "aws_instance" "my_ec2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.my_sg.id]
  subnet_id                   = aws_subnet.subnet["sub_1"].id
  key_name                    = aws_key_pair.ssh_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EOF

  tags = {
    Name = "wordpress-ec2"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "security group for RDS"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "rds-sg"
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.my_sg.id]
  }
}

resource "aws_db_instance" "my_rds_db" {
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  storage_type           = var.storage_type
  username               = var.username
  password               = var.password
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.my_db_sub_g.name
  identifier             = "wordpress"
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "wordpress_db"
  }
}

resource "aws_db_subnet_group" "my_db_sub_g" {
  name       = "mysql-sub-group"
  subnet_ids = [aws_subnet.subnet["priv_sub_4"].id, aws_subnet.subnet["priv_sub_5"].id, aws_subnet.subnet["priv_sub_6"].id]

  tags = {
    Name = "Mysql DB subnet group"
  }
}

