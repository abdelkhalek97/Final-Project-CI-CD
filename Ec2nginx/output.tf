output "instance_id" {
  value = tolist(aws_instance.ec2.*.id)
}

output "instance_id_priv" {
  value = tolist(aws_instance.ec2_priv.*.id)
}
