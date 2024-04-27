variable "subnets" {
  type        = map(object({name=string, cidr=string, az=string, public=bool}))
  default     = {
    "public_subnet" = {
       name="public",
       cidr= "10.0.0.0/24" 
       az="us-east-1a",
       public=true
   }
}
}