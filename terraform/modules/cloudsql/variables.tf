variable "instance_name" {
  type = string
}

variable "database_version" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type = string
}

variable "root_password" {
  type      = string
  sensitive = true
}
