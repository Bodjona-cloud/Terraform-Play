module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "my-ec2-cluster"
  instance_count = var.instance_count

  ami                    = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.terra-elb-sg.id]
  subnet_id              = module.vpc.public_subnets[0]
#   instance_key_name = var.instance_key_pair
  monitoring = var.ec2_monitoribg
  associate_public_ip_address = var.associate_public_ip_address
  user_data =   <<EOF
		#! /bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Static website deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
  EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}