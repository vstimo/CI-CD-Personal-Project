output "vpc_id" {
  description = "Id of the vpc"
  value = aws_vpc.main_vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}