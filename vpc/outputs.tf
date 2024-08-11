###############################################################################
# Google VPC Configuration Module
# -----------------------------------------------------------------------------
# outputs.tf
###############################################################################

output "network" {
  value       = google_compute_network.network
  description = "The VPC resource being created"
}

output "network_name" {
  value       = google_compute_network.network.name
  description = "The name of the VPC being created"
}

output "network_id" {
  value       = google_compute_network.network.id
  description = "The ID of the VPC being created"
}

output "network_self_link" {
  value       = google_compute_network.network.self_link
  description = "The URI of the VPC being created"
}

output "project_id" {
  value       = var.shared_vpc_host && length(google_compute_shared_vpc_host_project.shared_vpc_host) > 0 ? google_compute_shared_vpc_host_project.shared_vpc_host[0].project : google_compute_network.network.project
  description = "VPC project id"
}

output "nat_ips" {
  value = google_compute_address.address.*.address
  description = "Nat Ips"
}

# output "private_conn" {
#   value = google_service_networking_connection.private_service_connection[0].network
#   description = "The network of the private service connection."
# }

