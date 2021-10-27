variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "Region of the VPC"
}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  type = list
}
variable "availability_zones" {
  type = list
  default   = ["us-east-1a", "us-east-1b"]
}
variable "key_name" {
  default = "VirginiaKey"
  type = string
  description = "KeyName to be used for webservers"
}

variable "instance_type" {
  type = map
  default = {
    1 = "t2.micro"
    2 = "t3.micro"
    3 = "t2.medium"
  }
}

variable "image_id" {
  description = "ami"
  type = string
  default = "ami-09e67e426f25ce0d7"
  
}
