data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.27."
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = var.cluster_name
  location   = var.region
  cluster    = var.cluster_name
  version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    service_account = var.service_account

    labels = {
      env = var.project_id
    }
 
    # preemptible  = true
    disk_size_gb    = 50
    disk_type       = "pd-standard"
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
