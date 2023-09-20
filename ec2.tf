resource "aws_instance" "my-ec2" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  key_name                    = var.key-name
  subnet_id                   = aws_subnet.public-subnet1.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  tags = {
    Name : "TF-ec2-instance"
    env : "dev"
  }


}

resource "aws_instance" "private-instance" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = var.key-name
    subnet_id = aws_subnet.private-subnet1.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]
    associate_public_ip_address = true
  
}

  
resource "aws_security_group" "my-sg" {
  name        = "Aws-Security-Group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.sample-vpc.id


  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }

}