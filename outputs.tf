output "vpc-ip" {
  value = aws_vpc.sample-vpc.id

}
output "public-subnet1-id" {
  value = aws_subnet.public-subnet1.id
}
output "public-subnet2-id" {
  value = aws_subnet.public-subnet2.id
}
output "public-subnet3-id" {
  value = aws_subnet.public-subnet3.id
}
output "private-subnet1-id" {
  value = aws_subnet.private-subnet1.id
}
output "private-subnet2-id" {
  value = aws_subnet.private-subnet2.id
}
output "private-subnet3-id" {
  value = aws_subnet.private-subnet3.id
}

/*output "ec2-ip" {
  value = aws_instance.my-ec2.public_ip

}*/
