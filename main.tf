#####################
#VPC
#####################
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.47.0"
    }
  }
}

variable "vpc_id" {
    default = "vpc-0f77ff61e8282ac01"
}

data "aws_vpc" "my-vpc" {
    id = var.vpc_id

}

#############################################################
#subnet
#############################################################
resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.my-vpc.id
  cidr_block = var.subnets.public_subnet.cidr
  availability_zone = var.subnets.public_subnet.az
  map_public_ip_on_launch = var.subnets.public_subnet.public 
 tags = {
    Name =  "${var.subnets.public_subnet.name}_subnet"
  }
  
}

#############################################################
#instance1
#############################################################
resource "aws_instance" "test1" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = false
    prevent_destroy = false
    

  }

  tags = {
    Name = "HelloWorld"
  }
}










