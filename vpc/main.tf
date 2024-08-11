
/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "network" {
  name                                      = var.network_name
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = var.routing_mode
  project                                   = var.project_id
  description                               = var.description
  delete_default_routes_on_create           = var.delete_default_internet_gateway_routes
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.enable_ipv6_ula
  internal_ipv6_range                       = var.internal_ipv6_range
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  provider = google-beta

  count      = var.shared_vpc_host ? 1 : 0
  project    = var.project_id
  depends_on = [google_compute_network.network]
}

/******************************************
	NAT configuration
 *****************************************/
resource "google_compute_address" "address" {
  count  = var.enable_cloud_nat == true ? var.nat_ip_count : 1
  name   = "nat-manual-ip-${count.index}"
  region = var.gcp_region
}

resource "google_compute_router" "router" {
  count   = var.enable_cloud_nat ? 1 : 0
  name    = format("%s-router", var.network_name)
  network = google_compute_network.network.self_link
  region  = var.gcp_region
}

resource "google_compute_router_nat" "nat" {
  count  = var.enable_cloud_nat ? 1 : 0
  name   = "${var.network_name}-router-nat"
  router = google_compute_router.router[0].name
  region = var.gcp_region

  nat_ip_allocate_option = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ips                = google_compute_address.address.*.self_link
  log_config {
    enable = true
    filter = "ALL"
  }
}


resource "google_compute_global_address" "private_ip_address" {
  count = var.enable_private_service_conn ? 1 : 0
  name = "private-ip-address"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 24
  network = google_compute_network.network.id
}

resource "google_service_networking_connection" "private_service_connection" {
  count  = var.enable_private_service_conn ? 1 : 0
  network = google_compute_network.network.name
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = length(google_compute_global_address.private_ip_address) > 0 ? [google_compute_global_address.private_ip_address[0].name] : []
}

resource "google_compute_network_peering_routes_config" "peering_routes" {
  count  = var.enable_private_service_conn ? 1 : 0
  peering = google_service_networking_connection.private_service_connection[0].peering
  network = google_compute_network.network.name

  import_custom_routes = true
  export_custom_routes = true
}

