output "cluster_name" {
  description = "ECS cluster name, useful for debugging or CLI."
  value       = aws_ecs_cluster.cluster.name
}

output "service_name" {
  description = "ECS service name (for CLI describe/list commands)."
  value       = aws_ecs_service.ecs.name
}

# output "log_group_name" {
#   description = "CloudWatch Logs group receiving container logs."
#   value       = aws_cloudwatch_log_group.cloudwatch.name
# }
