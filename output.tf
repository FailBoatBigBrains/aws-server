output "public_ip" {
  description = "ips"
  value       = module.ec2_cluster.public_ip[0]
}
