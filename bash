mkdir -p docker terraform/modules/cloudsql .github/workflows public
touch docker/Dockerfile docker/nginx.conf public/index.php terraform/main.tf terraform/variables.tf terraform/backend.tf terraform/modules/cloudsql/main.tf .github/workflows/deploy.yml .gitignore README.md
