provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = var.cid_blk
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.sub1_cid_blk

  tags = {
    Name =  "sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.sub2_cid_blk

  tags = {
    Name = "sub2"
  }
}