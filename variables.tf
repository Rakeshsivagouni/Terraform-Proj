variable "region" {
  default = "us-east-1"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}
variable "public-subnet-1" {
  default = "10.0.1.0/24"
}
variable "public-subnet-2" {
  default = "10.0.2.0/24"
}
variable "public-subnet-3" {
  default = "10.0.3.0/24"
}

variable "private-subnet-1" {
  default = "10.0.4.0/24"
}
variable "private-subnet-2" {
  default = "10.0.5.0/24"
}
variable "private-subnet-3" {
  default = "10.0.6.0/24"
}
variable "key-name" {
  default = "Rakesh-Virginia"
}
variable "instance-type" {
  default = "t2.micro"
}
variable "ami-id" {
  default = "ami-04cb4ca688797756f"

}

