variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "db_name" {
  description = "Cloud SQL database name"
  type        = string
}

variable "db_instance_name" {
  description = "Cloud SQL instance name"
  type        = string
}

variable "db_root_password" {
  description = "Root password for the database"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Cloud Storage bucket name"
  type        = string
}
