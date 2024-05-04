

############################
#aws_availability_zones
############################


data "aws_availability_zones" "available" {}


############################
#Public-subnet
############################

resource "aws_subnet" "public_subnet" {
  count                   = var.subnet_count
  vpc_id                  = var.vpc-id
  cidr_block              = var.public_subnet[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

############################
#private-subnet
############################


resource "aws_subnet" "private_subnet" {
  count                   = var.subnet_count
  vpc_id                  = var.vpc-id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "Private_Subnet_${count.index + 1}"
  }
}

########################################################
#route table public and route-table-association
########################################################
resource "aws_route_table" "pub-route-tables" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "route-public-table "
  }
}

resource "aws_route_table_association" "route-table-association-subnet-igw" {
  count           = length(aws_subnet.public_subnet)
  subnet_id       = aws_subnet.public_subnet[count.index].id
  route_table_id  = aws_route_table.pub-route-tables.id
}

########################################################
#route table private and route-table-association
########################################################


resource "aws_route_table" "priv-route-tables" {
  vpc_id = var.vpc-id

  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = var.nat_id
  }
  tags = {
    Name = "route-private-table"
  }
}


resource "aws_route_table_association" "route-table-association-subnet-ngw" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.priv-route-tables.id
  
}


