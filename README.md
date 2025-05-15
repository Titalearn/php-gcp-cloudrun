
# PHP on Google Cloud Platform — CI/CD with Terraform, Cloud Build & Cloud Run

##  Overview

This project demonstrates how to deploy a PHP-FPM application served by NGINX on **Google Cloud Run**, using **Infrastructure as Code** via **Terraform**, automated containerization and deployment via **GitHub Actions** and **Cloud Build**, and secure, scalable infrastructure components like Cloud SQL, Cloud Storage, and Load Balancing.

Cloud logs have been redirected to a **Google Cloud Storage bucket** for simplified log aggregation and analysis.


---

##  1. Infrastructure as Code with Terraform

###  Resources Provisioned:
- Cloud SQL (MySQL)
- Google Cloud Storage bucket for static files & logs
- Cloud Run service running PHP-FPM behind NGINX
- HTTPS Load Balancer to route external traffic
- Logging bucket used as Terraform backend for state files

###  Modules & Variables
- Cloud SQL and Cloud Run resources are modularized under `terraform/modules/`
- Configurations like DB name, instance size, and bucket names are defined as variables for multi-env flexibility

###  State Management
Terraform backend is configured to use a **GCS bucket** for state files:

```hcl
terraform {
  backend "gcs" {
    bucket = "valid-kayak-terraform-state"
    prefix = "state"
  }
}
````

###  Documentation

All Terraform code is commented and references the official [GCP Terraform Provider documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs).

---

##  2. CI/CD Pipeline with GitHub Actions & Cloud Build

###  Workflow Highlights:

* On push to `main`, GitHub Actions triggers:

  1. Docker build of the PHP application
  2. Push to **Google Container Registry**
  3. Deployment to **Cloud Run** via `gcloud deploy`
  4. Logging to a custom GCS bucket

###  Secrets & Configs:

* Secrets (like DB credentials) are stored securely in **GitHub Secrets**
* Logs are not sent to Cloud Logging but redirected to `valid-kayak-logs` bucket using custom IAM and log settings

###  Testing (Optional):

Unit and integration test scaffolds can be added and integrated into the workflow for CI quality checks.

---

##  3. Bash Script for Cloud Run IP Retrieval

File: `scripts/get-ip.sh`

###  Features:

* Retrieves the public IP of the deployed Cloud Run Load Balancer
* Supports environment-specific queries via CLI argument
* Includes error handling and timestamped logging for audit

```bash
./scripts/get-ip.sh dev
```

---

##  4. Instructions

### ▶️ Run Terraform to Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Set these environment variables if required:

```bash
export TF_VAR_db_name="mydb"
export TF_VAR_bucket_name="valid-kayak-static"
```

---

###  Deploy Application (Manually or via GitHub Actions)

```bash
gcloud builds submit --config=cloudbuild.yaml
```

Or trigger by pushing to the `main` branch.

---

###  Access the Deployed Application

Visit the HTTPS Load Balancer IP (retrieved via the bash script) or go directly to the Cloud Run service URL if bypassing load balancing.

---

###  Troubleshooting Tips

* **Permission errors**: Make sure `roles/logging.logWriter` is granted to both the Compute and Cloud Build service accounts.
* **Build errors**: Ensure `Dockerfile` and `public/` are correctly placed in your Docker context.
* **Cloud Build IAM**: Use `roles/cloudbuild.builds.editor` or `roles/cloudbuild.workerPoolUser` as needed.

---

##  Additional Files

###  `dr.md` – Disaster Recovery Plan

Outlines strategies like:

* Cloud SQL backups
* Load Balancer health checks
* Versioned GCS storage
* Multi-region deployment potential

###  `extra.md` – Cool Extras

Showcases:

* Regional log bucket as build log sink
* Terraform modularization
* Potential Firebase Hosting alternative
* Docker multi-stage build optimization (planned)

---

##  Potential Production Enhancements

*  Monitoring & Alerting via Cloud Monitoring
*  Secret Manager integration for DB credentials
*  VPC-SC for private Cloud SQL access
*  Custom domain & managed SSL certs
*  Auto-scaling based on traffic patterns

---

##  Author

**Lavet Emmanuel**
GitHub: [@Titalearn](https://github.com/Titalearn)

