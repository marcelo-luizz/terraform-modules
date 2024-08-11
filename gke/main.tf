locals{
  master_authorized_networks_config = length(var.master_authorized_networks) == 0 ? [] : [{
    cidr_blocks : var.master_authorized_networks
  }]
}

resource "google_container_cluster" "primary" {
  name            = var.cluster_name
  # description     = var.description
  project         = var.project_id
  location        = var.region
  deletion_protection = var.deletion_protection
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = 1
  network    = var.network_name
  subnetwork = var.subnet_name

  dynamic "master_authorized_networks_config" {
    for_each = local.master_authorized_networks_config
    content {
      dynamic "cidr_blocks" {
        for_each = master_authorized_networks_config.value.cidr_blocks
        content {
          cidr_block   = lookup(cidr_blocks.value, "cidr_block", "")
          display_name = lookup(cidr_blocks.value, "display_name", "")
        }
      }
    }
  }  

  dynamic "private_cluster_config" {
    for_each = var.enable_private_nodes ? [{
      enable_private_nodes    = var.enable_private_nodes,
      enable_private_endpoint = var.enable_private_endpoint
      master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    }] : []

    content {
      enable_private_endpoint = private_cluster_config.value.enable_private_endpoint
      enable_private_nodes    = private_cluster_config.value.enable_private_nodes
      master_ipv4_cidr_block  = private_cluster_config.value.master_ipv4_cidr_block
      dynamic "master_global_access_config" {
        for_each = var.master_global_access_enabled ? [var.master_global_access_enabled] : []
        content {
          enabled = master_global_access_config.value
        }
      }
    }
  }


  ip_allocation_policy {
    cluster_secondary_range_name  = var.range_pods
    services_secondary_range_name = var.range_services
    # stack_type = var.stack_type
  }

  node_config {
      
      disk_size_gb    = 50
      disk_type       = "pd-standard"
  }
}




