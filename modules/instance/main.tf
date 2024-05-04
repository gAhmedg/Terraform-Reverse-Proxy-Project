############################
#EC2
############################

resource "aws_instance" "ec2" {
    ami                     =   var.ami-id
    instance_type           =   var.instance_type
    user_data               =   var.user_data
    subnet_id               =   var.subnet_id
    associate_public_ip_address   = true
    vpc_security_group_ids  =   var.vpc_security_group_ids
    key_name                =   var.key_name
    tags                    =   var.instance_tags
    security_groups         = [aws_security_group.sg.id]
}


resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "sg"
  }
}