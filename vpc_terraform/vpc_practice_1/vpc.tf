provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    Name = "volodymyrs-vpc"
    Comment = "Managed By Terraform"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "vpc-0dc0e3a502dd512a1"
  cidr_block = "10.100.10.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = "vpc-0dc0e3a502dd512a1"
  cidr_block = "10.100.20.0/24"

  tags = {
    Name = "subnet2"
  }
}