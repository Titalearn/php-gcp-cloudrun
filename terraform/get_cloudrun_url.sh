#!/bin/bash

# Description:
# This script retrieves the public URL of a deployed Google Cloud Run service.
# It accepts an environment name (e.g., dev, staging, prod) as an argument.
# Logs all outputs and errors to a file for debugging.

# Usage:
# ./get_cloudrun_url.sh dev

# Exit immediately on errors and undefined variables
set -euo pipefail

# === Configuration ===
PROJECT_ID="valid-kayak-459809-t2"
REGION="us-central1"
LOG_FILE="./cloudrun_lookup.log"

# === Input validation ===
ENVIRONMENT=${1:-}

if [[ -z "$ENVIRONMENT" ]]; then
  echo "❌ Error: Environment name is required as an argument." | tee -a "$LOG_FILE"
  echo "Usage: ./get_cloudrun_url.sh <environment>" | tee -a "$LOG_FILE"
  exit 1
fi

SERVICE_NAME="php-app-${ENVIRONMENT}" # Example: php-app-dev, php-app-prod

echo "🔍 Looking up Cloud Run service: $SERVICE_NAME in region: $REGION (project: $PROJECT_ID)" | tee -a "$LOG_FILE"

# === Try to retrieve Cloud Run URL ===
SERVICE_URL=$(gcloud run services describe "$SERVICE_NAME" \
  --project="$PROJECT_ID" \
  --region="$REGION" \
  --format='value(status.url)' 2>>"$LOG_FILE") || {
    echo "❌ Failed to retrieve service URL. Check if the service exists and permissions are correct." | tee -a "$LOG_FILE"
    exit 1
  }

# === Output result ===
if [[ -z "$SERVICE_URL" ]]; then
  echo "❌ No URL found. Cloud Run service might not be deployed." | tee -a "$LOG_FILE"
  exit 1
else
  echo "✅ Cloud Run service URL: $SERVICE_URL" | tee -a "$LOG_FILE"
fi
