variable "region" {
    default = "us-east-1"
}


variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2 
}
variable "private_subnet" {
    description = "CIDR blocks for private subnets"
    type        = list(string)
    default     = ["10.0.1.0/24","10.0.3.0/24"]
}

variable "public_subnet" {
    description = "CIDR blocks for public subnets"
    type        = list(string)
    default     = ["10.0.0.0/24","10.0.2.0/24"]

}
variable "ami-id" {
    description = "The ID of the AMI to use for the EC2 instance"
    default = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro" 
}

variable "user_data_apache" {
  description = "The user data to provide when launching the EC2 instance"
  type        = string
  default     = null
}
# loadbalancer module variables
variable "lb_internal"{
  default = false
}
variable "user_data_proxy" {
  description = "The user data to provide when launching the EC2 instance"
  type        = string
  default     = null
}



variable "tags" {
  
    description = "A map of tags to assign to the EC2 instances"
    type        = map(string)
    default     = { }
}







