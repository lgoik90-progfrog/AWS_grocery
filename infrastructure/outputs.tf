output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = aws_security_group.grocerymate_web_sg.id
}