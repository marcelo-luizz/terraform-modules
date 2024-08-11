output "instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.instance.connection_name
}

output "instance_self_link" {
  description = "The self link of the Cloud SQL instance"
  value       = google_sql_database_instance.instance.self_link
}

# output "databases" {
#   description = "The list of databases created in the instance"
#   value       = google_sql_database.databases[*].name
# }

output "users" {
  description = "The list of users created in the instance"
  value       = google_sql_user.users[*].name
}

output "sql_instance_private_ip" {
  value = google_sql_database_instance.instance.ip_address
  description = "The private IP address of the Cloud SQL instance."
}

output "sql_instance_private_ip_replica" {
  value = var.enable_replica ? google_sql_database_instance.read_replica[*].ip_address : null
  description = "The private IP address of the Cloud SQL instance Replica"
}
