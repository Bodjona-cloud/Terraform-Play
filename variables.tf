variable "vpc_name" {
  type = string
}
variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnets" {
  type = list
}
variable "availability_zones" {
  type = list
}

variable "instance_type" {
  type = string
  
  }

variable "image_id" {
  description = "ami"
  type = string
    
}

variable "enable_nat_gateway" {
  description = "enable NAT Gateway"
  type        = bool
}

# variable "single_nat_gateway" {
#   description = "enable single NAT Gateway in one public subnet"
#   type        = bool
# }


# variable "one_nat_gateway_per_az" {
#   description = "enable NAT Gateway per az"
#   type        = bool
# }
variable "enable_dns_support" {
  description = "enable DNS Support"
  type        = bool
}


variable "enable_dns_hostnames" {
  description = "enable DNS hostnames"
  type        = bool
}

variable "instance_count" {
  type = number
}

variable "ec2_monitoribg" {
  type = bool
}

variable "instance_key_pair" {
  type = string
}
# variable "vpc_tags" {
#   type = string
# }
variable "associate_public_ip_address" {
  type = bool
}