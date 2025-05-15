provider "google" {
  project = var.project_id
  region  = var.region
}

module "cloudsql" {
  source           = "./modules/cloudsql"
  instance_name    = var.db_instance_name
  database_version = "MYSQL_8_0"
  db_name          = var.db_name
  root_password    = var.db_root_password
  region           = var.region
}

resource "google_storage_bucket" "static_bucket" {
  name     = var.bucket_name
  location = var.region

  uniform_bucket_level_access = true
  force_destroy               = true
}

output "bucket_url" {
  value = "gs://${google_storage_bucket.static_bucket.name}"
}

output "cloudsql_instance_connection_name" {
  value = module.cloudsql.connection_name
}
resource "google_project_iam_binding" "logging_writer" {
  project = "valid-kayak-459809-t2"
  role    = "roles/logging.logWriter"

  members = [
    "serviceAccount:454751535014-compute@developer.gserviceaccount.com",
  ]
}