provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "testec2" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "vs-tf-ec2"
    comment = "Managed By Terraform"
  }
} 

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow inbound SSH traffic"
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.8.111.221/32"]
  }
}

# resource "aws_network_interface_sg_attachment" "sg_attachment" {
#   security_group_id    = aws_security_group.allow_ssh.id
#   network_interface_id = aws_instance.testec2.primary_network_interface_id
# }