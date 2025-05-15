resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  region           = var.region
  database_version = var.database_version

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.default.name
  password = var.root_password
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.default.name
}

output "connection_name" {
  value = google_sql_database_instance.default.connection_name
}
