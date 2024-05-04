output "id" {
  description = "The ID of the instance"
  value =aws_instance.ec2.id
   
}


output "security_group_id" {
    value = aws_security_group.sg.id
}





