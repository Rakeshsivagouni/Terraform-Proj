terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket  = "rakesh-terraform-state-file"
    key     = "global/terraform.tfstate"
    region  = "us-east-1"
    profile = "env-admin"
  }
}

provider "aws" {
  region  = var.region
  profile = "env-admin"
}
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "rakesh-terraform-state-file"
  lifecycle {
    prevent_destroy = true
  }
}
# 1. Creating VPC
resource "aws_vpc" "sample-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name : "sample-vpc"
    env : "dev"
  }
}
# 2. Creating IGW
resource "aws_internet_gateway" "samplevapc-IGW" {
  vpc_id = aws_vpc.sample-vpc.id
}
#3. Creating public routetable
resource "aws_route_table" "public-routetable" {
  vpc_id = aws_vpc.sample-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.samplevapc-IGW.id
  }
  tags = {
    Name : "public-routetable"
    env : "dev"
  }
}
# 4. Assiging route tables to subnet
resource "aws_route_table_association" "pub-ass" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.public-routetable.id

}
resource "aws_route_table_association" "pub-ass2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.public-routetable.id

}
resource "aws_route_table_association" "pub-ass3" {
  subnet_id      = aws_subnet.public-subnet3.id
  route_table_id = aws_route_table.public-routetable.id

}
#5. Craeting private routetable
resource "aws_route_table" "privateroute-table" {
  vpc_id = aws_vpc.sample-vpc.id
  tags = {
    Name : "private-routetable"
    env : "dev"
  }

}
#6. Creating public subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id            = aws_vpc.sample-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = var.public-subnet-1
  tags = {
    Name : "public-subnet1"
    env : "dev"
  }

}
resource "aws_subnet" "public-subnet2" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.public-subnet-2
  availability_zone = "us-east-1b"
  tags = {
    Name : "public-subnet2"
    env : "dev"
  }

}
resource "aws_subnet" "public-subnet3" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.public-subnet-3
  availability_zone = "us-east-1c"
  tags = {
    Name : "public-subnet3"
    env : "dev"
  }

}
#7. Creating private subnets
resource "aws_subnet" "private-subnet1" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.private-subnet-1
  availability_zone = "us-east-1a"
  tags = {
    Name : "private-subnet1"
    env : "dev"
  }

}
resource "aws_subnet" "private-subnet2" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.private-subnet-2
  availability_zone = "us-east-1b"
  tags = {
    Name : "private-subnet2"
    env : "dev"
  }

}
resource "aws_subnet" "private-subnet3" {
  vpc_id            = aws_vpc.sample-vpc.id
  cidr_block        = var.private-subnet-3
  availability_zone = "us-east-1c"
  tags = {
    Name : "private-subnet3"
    env : "dev"
  }
}
#8. Assiging private routettable to private subnets
resource "aws_route_table_association" "pri-ass1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.privateroute-table.id

}
resource "aws_route_table_association" "pri-ass2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.privateroute-table.id

}
resource "aws_route_table_association" "pri-ass3" {
  subnet_id      = aws_subnet.private-subnet3.id
  route_table_id = aws_route_table.privateroute-table.id

}

# 9. Create an Elastic IP for the NAT Gateway
resource "aws_eip" "eip" {}
#10. Creating NatGatway
resource "aws_nat_gateway" "dev-NAT-GW" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet1.id
  #subnet_id = aws_subnet.public-subnet1.id 
}
#10. Add a default route pointing to the NAT Gateway in the private route table
resource "aws_route" "private_subnet_default_route" {
  route_table_id         = aws_route_table.privateroute-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.dev-NAT-GW.id
}

