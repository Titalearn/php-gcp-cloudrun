/*terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "state/php-cloudrun"
  }
}
*/

terraform {
  backend "gcs" {
    bucket  = "terraform-state-459809"
    prefix  = "state/dev"
  }
}
