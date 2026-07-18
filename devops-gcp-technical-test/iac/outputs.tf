output "cloud_run_url" {
  description = "URL of the deployed Cloud Run service"
  value       = google_cloud_run_service.default.status[0].url
}

output "cloud_sql_connection_name" {
  description = "Connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.connection_name
}

output "cloud_sql_private_ip" {
  description = "Private IP of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.private_ip_address
}

output "vpc_name" {
  description = "Name of the created VPC"
  value       = google_compute_network.vpc.name
}
