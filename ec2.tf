resource "aws_instance" "my-ec2" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  key_name                    = var.key-name
  subnet_id                   = aws_subnet.public-subnet1.id
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  user_data = file("docker.sh")
  tags = {
    Name : "TF-ec2-instance"
    env : "dev"
  }


}

/*resource "aws_instance" "second-instance" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = var.key-name
    subnet_id = aws_subnet.public-subnet2.id
    vpc_security_group_ids = [aws_security_group.my-sg.id]
    associate_public_ip_address = true
    user_data = <<EOF
             #!/bin/bash
			 sudo yum update -y && sudo yum install -y docker
			 sudo systemctl start docker
			 sudo usermod -aG docker ec2-user
			 sudo docker run -p 8080:80 nginx
			 EOF

    tags = {
      Name: "web-server"
      env: "dev"
    }
  
}*/

  
resource "aws_security_group" "my-sg" {
  name        = "web-sg"
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
  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
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
resource "aws_security_group" "rds-sg" {
  name = "db-sg"
  vpc_id = aws_vpc.sample-vpc.id
   ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
   }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name: "db-sg"
    env: "dev"
  }

  }

  




