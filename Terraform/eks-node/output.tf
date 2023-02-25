output "iam_id" {
  value = aws_iam_role.nodes.id

}

output "node-ip" {
  value = data.aws_instances.my_worker_nodes.private_ips[0]

}