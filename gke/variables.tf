


variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
  default     = ""
}
variable "region" {
  default = ""
}

variable "network_name" {
  description = "Name of the network this set of firewall rules applies to."
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Subnet Name."
  default     = ""
}


variable "cluster_name" {
  default     = ""
  description = "Cluster Name"
}

variable "remove_default_node_pool" {
  default     = ""
  description = "Default Node"
}


variable "deletion_protection" {
  default     = ""
  description = "Proteção de exclusão"
}


variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}


variable "range_pods" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "range_services" {
  type        = string
  description = "The _name_ of the secondary subnet range to use for services"
}




variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  default     = []
}

variable "master_global_access_enabled" {
  type        = bool
  description = "Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint."
  default     = true
}

variable "enable_private_endpoint" {
  type        = bool
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
  default     = false
}

variable "enable_private_nodes" {
  type        = bool
  description = "(Beta) Whether nodes have internal IP addresses only"
  default     = false
}

variable "master_ipv4_cidr_block" {
  description = "(Beta) Whether nodes have internal IP addresses only"
  default     = ""
}

