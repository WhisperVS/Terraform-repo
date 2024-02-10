provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mys3buck" {
  bucket = var.bucket_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

