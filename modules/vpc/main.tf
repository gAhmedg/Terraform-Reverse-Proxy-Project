############################
#VPC
############################
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block

}

############################
#internet_gateway
############################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "my igw"
  }
}




#########################################
# Create an Elastic IP for the NAT gateway
#########################################
resource "aws_eip" "nat_eip" {
  domain   = "vpc"
}

# CREATE NAT IN THE FIRST PUBLIC SUBNET
resource "aws_nat_gateway" "nat" {
  
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = var.subnet_nat_id
  depends_on    = [aws_internet_gateway.igw]

  
}


