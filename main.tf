resource "aws_vpc" "terra-vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "terra-vpc"
  }  
}

resource "aws_internet_gateway" "terra-igw" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "terra-igw"
  }    
}

resource "aws_route_table" "terra-public-route" {
  vpc_id = aws_vpc.terra-vpc.id
  tags = {
    Name = "terra-public-route"
  }    
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.terra-public-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terra-igw.id
}

resource "aws_subnet" "terra-pub-subnet" {
  vpc_id                  = aws_vpc.terra-vpc.id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "terra-pub-subnet"
  }     
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_blocks)
  subnet_id  = aws_subnet.terra-pub-subnet.id
  route_table_id = aws_route_table.terra-public-route.id
}

resource "aws_security_group" "terra-sg" {
  name        = "terra-elb-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.terra-vpc.id
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
    Name = "terra-sg"
  }
}
resource "aws_instance" "terra-ubuntu" {
  ami = var.image_id
  instance_type = var.instance_type [1]
  key_name = var.key_name
  subnet_id = aws_subnet.terra-pub-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.terra-sg.id ]
  user_data = <<-EOF
		#! /bin/bash
        sudo apt-get update -y
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Bernadette deployed this static website via Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    "Name" = "terra-static-instance"
  }
}


