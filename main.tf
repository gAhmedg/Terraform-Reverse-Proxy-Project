############################
#VPC
############################
module "vpc" {
   
    source = "./modules/vpc"
#_____________________
    region = var.region
    subnet_count = var.subnet_count
    cidr_block = var.cidr_block
    private_subnet = var.private_subnet
    public_subnet =  var.public_subnet
    subnet_nat_id = element(module.subnets.public_subnet_ids, 0)
    public_subnet_id = module.subnets.public_subnet_ids
    private_subnet_id = module.subnets.private_subnet_ids


}
############################
#subnets
############################
module "subnets" {
   
    source = "./modules/subnets"
#_____________________
    igw_id       = module.vpc.igw_id
    nat_id       = module.vpc.nat_id
    subnet_count = var.subnet_count
    vpc-id = module.vpc.vpc_id
    private_subnet = var.private_subnet
    public_subnet =  var.public_subnet
   
}


############################
#private-apache-subnet
############################
module "ec2-private" {

    source                  =   "./modules/instance"
    vpc_id                  =   module.vpc.vpc_id
    count                   =   var.subnet_count
    ami-id                  =   var.ami-id
    instance_type           =   var.instance_type
    subnet_id               =   module.subnets.private_subnet_ids[count.index]
    key_name                =   "TF_key"
    depends_on              =   [ module.vpc ]
    instance_tags           =   {Name = "Private_${count.index + 1}"}  
    user_data               =  file("userdata-apache.sh")

}
############################
#public-NGINX(revers-proxy)
############################
module "ec2-public" {
#    ${module.Private_load_balancer.load_balancer_dns}
    source                  =   "./modules/instance"
    vpc_id                  =   module.vpc.vpc_id
    count                   =   var.subnet_count
    ami-id                  =   var.ami-id
    instance_type           =   var.instance_type
    subnet_id               =   module.subnets.public_subnet_ids[count.index]
    key_name                =   "TF_key"
    depends_on              = [ module.vpc   ]
    instance_tags           =   {Name = "Public_${count.index + 1}"} 
    user_data               = file("userdata-proxy.sh") 
}




############################
#LoadBalancer
############################

locals {
  list_of_strings = [for instance in module.ec2-private : instance.id]
  list_of_strings2 = [for instance in module.ec2-public : instance.id]
}


module "Private_load_balancer" {
   
    source = "./modules/loadbalancre"
#_____________________
    name_lb = "private-LB"
    lb_vpc_id = module.vpc.vpc_id
    target_id = local.list_of_strings
    lb_internal = true
    lb_subnets  = module.subnets.private_subnet_ids
    lb_sg_id  =  [for instance in module.ec2-private : instance.security_group_id]
    
}



module "Public_load_balancer" {
   
    source = "./modules/loadbalancre"
#_____________________
    name_lb = "public-LB"
    lb_vpc_id = module.vpc.vpc_id
    target_id = local.list_of_strings2
    lb_internal = false
    lb_subnets  = module.subnets.public_subnet_ids
    lb_sg_id  =  [for instance in module.ec2-public : instance.security_group_id]
    
    
}




