

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2 
}

variable "vpc-id" {
        type        = string

}


variable "private_subnet" {
    description = "CiDR  for private subnets"
    type        = list(string)
    
}

variable "public_subnet" {
    description = "CiDR  for public subnets"
    type        = list(string)

}
variable "igw_id"{
    description = "ID of the IGW "
    type = string
}
variable "nat_id"{
    description = "ID of the NAT "
    type = string
}

