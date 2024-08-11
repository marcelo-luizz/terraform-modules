resource "random_id" "db_name_suffix_master" {
  byte_length = 2
}

resource "random_id" "db_name_suffix_replica" {
  byte_length = 2
}

#Criando Instancia do Banco de dados
resource "google_sql_database_instance" "instance" {
  name             = "${var.name}-${random_id.db_name_suffix_master.hex}"
  database_version = var.database_version
  region           = var.region
  deletion_protection = var.deletion_protection

  settings {
    tier = var.tier
    availability_type = var.highly_available ? "REGIONAL" : null
    user_labels = var.db_labels

    ip_configuration {
      ipv4_enabled = var.ipv4_enabled
      private_network = var.custom_network

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = authorized_networks.value.name
          value = authorized_networks.value.value
        }
      }
    }

    insights_config {
        query_insights_enabled = true
    }
    backup_configuration {
      enabled    = var.backup_enabled
      start_time = var.backup_start_time
      point_in_time_recovery_enabled = var.pit_recovery_enabled
    }

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = database_flags.value.name
        value = database_flags.value.value
      }
    }

    maintenance_window {
      day  = var.maintenance_day
      hour = var.maintenance_hour
    }
  }

}

resource "google_sql_database_instance" "read_replica" {
  count = var.enable_replica ? 1 : 0
  name                 = "${var.name}-${random_id.db_name_suffix_replica.hex}"
  master_instance_name = "${google_sql_database_instance.instance.name}"
  region               = var.region
  database_version     = var.database_version
  deletion_protection = var.deletion_protection
  replica_configuration {
    failover_target = false
  }
  dynamic "settings" {
    for_each = var.replica_config
    content {
      tier              = settings.value.tier
      availability_type = "REGIONAL"
      disk_size         = settings.value.disk_size
      backup_configuration {
        enabled = false
      }

      ip_configuration {
        ipv4_enabled    = var.ipv4_enabled
        private_network = var.custom_network

        dynamic "authorized_networks" {
          for_each = var.authorized_networks
          content {
            name  = authorized_networks.value.name
            value = authorized_networks.value.value
          }
        }
      }
    }
  }
}

#Criando Usuário
resource "google_sql_user" "users" {
  # count    = length(var.users)
  name     = "forestoken"
  instance = google_sql_database_instance.instance.name
  password = data.google_secret_manager_secret_version.postgres_password.secret_data
}

# #Criando Database
# resource "google_sql_database" "databases" {
#   # count    = length(var.databases)
#   name     = var.databases[count.index].name
#   instance = google_sql_database_instance.instance.name
#   charset  = var.databases[count.index].charset
# }


data "google_secret_manager_secret_version" "postgres_password" {
 secret   = "PG_PASSWORD"
}

resource "google_secret_manager_secret" "pg-host" {
  # project   = var.gcp_project
  secret_id = "PG_HOST"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "pg-host" {
  secret = google_secret_manager_secret.pg-host.id

  secret_data = google_sql_database_instance.instance.private_ip_address
}