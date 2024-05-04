# OUTPUT TO RETRIVE THE  LOAD BALANCER DNS
output "Public_load_balancer_dns" {
  value = module.Public_load_balancer.load_balancer_dns

} 
output "Private_load_balancer_dns" {
  value = module.Private_load_balancer.load_balancer_dns
  
} 
