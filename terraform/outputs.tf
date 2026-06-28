output "infrastructure_summary" {
  value = <<EOT
  AI for Free - Perfume AI Infrastructure
  
  Database:
    - Cluster Endpoint: ${aws_rds_cluster.ai_perfumer.endpoint}
    - Port: ${aws_rds_cluster.ai_perfumer.port}
    - Username: ${aws_rds_cluster.ai_perfumer.master_username}
  
  Backend:
    - ECR Repository: ${aws_ecr_repository.backend.repository_url}
  EOT
}
