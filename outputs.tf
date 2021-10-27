# Declare the region 
output "aws_region"{
  description = "AWS region"
  value = var.aws_region
}

# Declare the availability zones
output "availability_zones"{
  description = "AWS Availability Zones"
  value = var.availability_zones
}

# Declare the VPC
output "aws_vpc" {
  description = "VPC"
  value = aws_vpc.terra-vpc
}
# Decalre the public subnet
output "aws_subnet" {
  description = "public subnet"
  value = aws_subnet.terra-pub-subnet
}
# Declare Security Group
output "aws_security_group"{
  description = "Security group"
  value = aws_security_group.terra-sg
}









