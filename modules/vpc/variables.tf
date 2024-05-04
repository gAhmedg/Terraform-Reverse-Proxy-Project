variable "region" {
    default = "us-east-1"
}


variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2 
}


variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "private_subnet" {
    description = "CIDR blocks for private subnets"
    type        = list(string)
    
}
variable "public_subnet" {
    description = "CIDR blocks for public subnets"
    type        = list(string)

}
variable "subnet_nat_id"{
    description = "The subnet ID of the public subnet in which to place the gateway"
    type = string
}

variable "public_subnet_id" {
    description = "CIDR blocks for public subnets"
    type        = list(string)

}


variable "private_subnet_id" {
    description = "CIDR blocks for private subnets"
    type        = list(string)
    
}