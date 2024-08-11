variable "name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

# variable "gcp_project" {
#   type        = string
#   description = "The GCP project ID (may be a alphanumeric slug) that the resources are deployed in. (Example: my-project-name)"
# }

variable "database_version" {
  description = "The database version to use"
  type        = string
  default     = "MYSQL_5_7"
}

variable "region" {
  description = "The region to deploy the instance in"
  type        = string
  default     = "us-central1"
}

variable "tier" {
  description = "The machine type to use for the instance"
  type        = string
  default     = "db-f1-micro"
}

variable "ipv4_enabled" {
  description = "Whether the instance should have a public IP address"
  type        = bool
  default     = true
}

variable "authorized_networks" {
  description = "List of authorized networks"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "backup_enabled" {
  description = "Whether backup should be enabled"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Start time for the daily backup configuration in UTC (HH:MM format)"
  type        = string
  default     = "00:00"
}

variable "database_flags" {
  description = "Database flags to pass to the instance"
  type        = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "maintenance_day" {
  description = "Day of the week for maintenance (1-7)"
  type        = number
  default     = 7
}

variable "maintenance_hour" {
  description = "Hour of the day for maintenance (0-23)"
  type        = number
  default     = 23
}

variable "deletion_protection" {
  description = "Whether deletion protection should be enabled"
  type        = bool
  default     = false
}

variable "users" {
  description = "List of users to create in the instance"
  type = list(object({
    name     = string
    password = string
    host     = string
  }))
  default = []
}

variable "databases" {
  description = "List of databases to create in the instance"
  type = list(object({
    name      = string
    charset   = string
  }))
  default = []
}

variable "custom_network" {
  description = "Network Private Service Connection"
  type        = string
  default     = ""
}

variable "pit_recovery_enabled" {
  description = "a"
  type = bool
}

variable "db_labels" {
  description = "A set of key/value label pairs to assign to the resources."
  type        = map(string)
  default     = {}
}
variable "highly_available" {
  description = "a"
  type        = bool
  default     = true
}

variable "replica_config" {
  type = list(object({
    tier      = string
    disk_size = string
  }))
}

variable "enable_replica" {
  type    = bool
  default = true  # Define o valor padrão como true se não especificado explicitamente
}