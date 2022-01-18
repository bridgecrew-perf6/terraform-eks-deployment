output "private_subnets" {
  
  value = aws_subnet.private.*.id
  
  description = "Private Subnets"
}
output "public_subnets" {
  
  value = aws_subnet.public.*.id
  
  description = "Public Subnets"
}