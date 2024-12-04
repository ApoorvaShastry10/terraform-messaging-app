output "autoscaling_group_name" {
  value = aws_autoscaling_group.app.name
}

output "key" {
  value = aws_key_pair.key_pair.key_name
}