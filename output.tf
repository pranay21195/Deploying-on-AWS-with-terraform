output "backendserver-Private-IP" {
  value = aws_instance.backendserver.private_ip
}
output "frontendserver-Public-IPs" {
  value = aws_instance.frontendserver.public_ip
}

output "frontendserver-Private-IPs" {
  value = aws_instance.frontendserver.private_ip
}

output "alb_dns_name" {
  value = aws_lb.application-lb.dns_name
}
