variable "ami-id" {
    description = "The ID of the AMI to use for the EC2 instance"
    default = "ami-04b70fa74e45c3917"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  default     = "t2.micro" 
}

variable "user_data" {
  description = "The user data to provide when launching the EC2 instance"
  type        = string
  
}

variable "vpc_id" {

  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet in which to launch the EC2 instance"
  default     = null  
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with the EC2 instance"
  type        = list(string)
  default     = null
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the EC2 instance"
  type        = string
  default     = null  
}


variable "instance_tags" {
    description = "A map of tags to assign to the EC2 instances"
    type        = map(string)
    default     = {}
}

