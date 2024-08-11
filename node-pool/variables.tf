variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = ""
}

variable "gke_num_nodes" {
  description = "Num Nodes"
  default     = ""
}

variable "region" {
    default = ""
}

variable "service_account" {
  default = ""
}